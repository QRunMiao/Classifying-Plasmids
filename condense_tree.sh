#!/usr/bin/env bash

USAGE="
Usage: $0 NWK_FILE MAP_FILE NODE_COL GROUP_COL

Default values:
    NODE_COL    1
    GROUP_COL   2

#NWK_FILE 是进化树文件的路径和名称。
MAP_FILE 是一个映射文件的路径和名称。
NODE_COL 是一个可选参数，表示节点列的索引，默认值为 1。
GROUP_COL 是一个可选参数，表示组列的索引，默认值为 2

$ bash condense_tree.sh tree.newick taxon.tsv
"
# 是用于检查命令行参数的数量是否足够。如果参数数量不足，它会打印出用法信息并退出脚本。
if [ "$#" -lt 2 ]; then #$# 变量的值，它代表了命令行参数的数量
    echo >&2 "$USAGE"
    exit 1
fi

# Check whether newick-utils is installed #用于检查是否安装了 newick-utils 工具，并在未安装时给出相应的错误提示信息。
hash nw_clade 2>/dev/null || { #hash 是一个 Bash 内置命令，用于查找并记住命令的路径;这行代码尝试查找 nw_clade 命令，并将结果输出到标准输出流（默认情况下）
    echo >&2 "newick-utils is required but it's not installed.";
    echo >&2 "Install with homebrew: brew install brewsci/bio/newick-utils";
    exit 1;
}

# Set default parameters#是用于设置默认参数的。它将从命令行参数中获取 NWK_FILE 和 MAP_FILE 的值，并为 NODE_COL 和 GROUP_COL 设置默认值。
NWK_FILE=$1 #命令行参数 $1 和 $2 的值分别赋给变量 NWK_FILE 和 MAP_FILE
MAP_FILE=$2
NODE_COL=${3:-1} #${3:-1} 表示如果变量 $3 未定义或为空，则使用默认值 1
GROUP_COL=${4:-2} #${4:-2} 同样表示如果变量 $4 未定义或为空，则使用默认值 2
#即如果在执行脚本时只提供了 NWK_FILE 和 MAP_FILE，那么 NODE_COL 将默认为 1，GROUP_COL 将默认为 2

# Run #这段代码将参数的值打印到标准错误流中，并创建文件 condense.newick 和 condense.map
>&2 cat <<EOF #cat <<EOF 是一个 Here Document 的语法。它允许将多行文本作为输入传递给命令。EOF 是一个结束标记，表示文本输入结束
==> Parameters
NWK_FILE=${NWK_FILE}
MAP_FILE=${MAP_FILE}
NODE_COL=${NODE_COL}
GROUP_COL=${GROUP_COL}

Writing condense.newick and condense.map

EOF
#在这个 Here Document 中，文本内容包括了参数的名称和值，以及一条提示信息。参数的值被插入到文本中

#这行代码定义了一个临时目录 mytmpdir，它使用mktemp命令创建一个具有唯一名称的临时目录。如果mktemp命令不可用，则使用备用的命令mktemp -d -t 'mytmpdir'` 来创建临时目录。
mytmpdir=`mktemp -d 2>/dev/null || mktemp -d -t 'mytmpdir'`

nw_labels ${NWK_FILE} > ${mytmpdir}/labels.lst #提取进化树的节点标签

cat $MAP_FILE |
    grep -v "^#" | #过滤掉注释行
    tr " " "_" |
    tsv-join -k 1 -f ${mytmpdir}/labels.lst \
    > ${mytmpdir}/valid.tsv

cat ${mytmpdir}/valid.tsv |
    tsv-select -f $GROUP_COL |
    tsv-uniq |
    grep -v "NA" |
    grep "." \  #过滤掉空白行
    > ${mytmpdir}/group.lst

# Check monophyly for group
for GROUP in $(cat ${mytmpdir}/group.lst); do
    cat ${mytmpdir}/valid.tsv |
        tsv-filter --str-eq "$GROUP_COL:$GROUP" |
        tsv-select -f $NODE_COL \
        > ${mytmpdir}/${GROUP}.lst

    NODE=$(
        nw_clade -m ${NWK_FILE} $(cat ${mytmpdir}/${GROUP}.lst) | #-m:用于指定分子标签（molecular label）；${mytmpdir}/${GROUP}.lst 是一个文件路径表达式；文件路径表达式的格式通常由目录路径和文件名组成，相对路径（相对于当前工作目录来描述文件位置）、绝对路径（以根目录（通常表示为 /）作为起点的完整路径
            nw_stats -f l - | #计算子树的相关统计信息。-f l 参数指定输出格式为单独的一行；- 符号表示将输入从标准输入中获取。在这个命令中，- 表示将前一个命令（nw_clade 命令）的输出作为 nw_stats 命令的输入
            cut -f 3
    )

    if [[ "$NODE" ]]; then #"$NODE" 表示变量 NODE 的值;如果 NODE 存在值（非空），则条件为真。
        echo "${GROUP}" >> ${mytmpdir}/group.monophyly.lst #将组名 ${GROUP} 追加写入 ${mytmpdir}/group.monophyly.lst 文件中
        cat ${mytmpdir}/${GROUP}.lst |
            xargs -I[] echo "[] ${GROUP}___${NODE}" \  #xargs 命令将每一行作为参数传递给 echo 命令，并在每一行前面插入一对方括号 []，并附加组名 ${GROUP} 和 ___，以及变量 NODE 的值。
            >> ${mytmpdir}/group.monophyly.map
    fi

done

# Merge labels in group to a higher-rank #将group中的标签合并到更高的级别
nw_rename ${NWK_FILE} ${mytmpdir}/group.monophyly.map | #根据 ${mytmpdir}/group.monophyly.map 文件中的映射关系，将 ${NWK_FILE} 文件中的标签进行重命名。
    nw_condense - \  #对前一个命令的输出进行压缩和修剪; - 参数表示从标准输入（即前一个命令的输出）读取树的数据。
    > ${mytmpdir}/group.monophyly.newick

# Outputs
mv ${mytmpdir}/group.monophyly.newick condense.newick
mv ${mytmpdir}/group.monophyly.map condense.map

rm -fr ${mytmpdir}
