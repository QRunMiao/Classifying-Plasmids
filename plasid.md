**NCBI RefSeq (NCBI Reference Sequence Database): 一套全面、集成、非冗余、注释良好的参考序列，包括基因组、转录本和蛋白质**
1. 下载数据
```
mkdir -p data/plasmid
cd data/plasmid
rsync -avP ftp.ncbi.nlm.nih.gov::refseq/release/plasmid/ RefSeq/

rsync用于文件同步.它可以在本地计算机与远程计算机之间，或者两个本地目录之间同步文件（但不支持两台远程计算机之间的同步）。它也可以当作文件复制工具，替代cp和mv命令
-a --archive ：归档模式，表示递归传输并保持文件属性。等同于"-rtopgDl"
-v：显示rsync过程中详细信息。可以使用"-vvvv"获取更详细信息。
-P：显示文件传输的进度信息。(实际上"-P"="–partial --progress"，其中的"–progress"才是显示进度信息的)

递归（recursion）的定义： 简单说程序调用自身的编程技巧叫递归。递归的思想是把一个大型复杂问题层层转化为一个与原问题规模更小的问题，问题被拆解成子问题后，递归调用继续进行，直到子问题无需进一步递归就可以解决的地步为止。 
```
2. 处理gbff文件：注释文件
```
gzip -dcf RefSeq/*.genomic.gbff.gz > genomic.gbff

-d或--decompress或----uncompress 　解开压缩文件
-c或--stdout或--to-stdout 　把压缩后的文件输出到标准输出设备，不去更动原始文件
-f或--force 　强行压缩文件。不理会文件名称或硬连接是否存在以及该文件是否为符号连接

gbff是NCBI基因组数据库常见的基因组genebank格式文件，在实际分析中，常常需要gff格式或者gtf格式，所以就存在gbff转换gff格式的需求
```
进程

```
Welcome to the NCBI rsync server.


receiving incremental file list
created directory RefSeq
./
plasmid.1.1.genomic.fna.gz
    181,731,328  59%  183.91kB/s    0:11:11
    305,217,663 100%  176.01kB/s    0:28:13 (xfr#1, to-chk=28/30)
plasmid.1.2.genomic.fna.gz
    112,015,213 100%  239.16kB/s    0:07:37 (xfr#2, to-chk=27/30)
plasmid.1.genomic.gbff.gz
    347,973,266 100%  467.85kB/s    0:12:06 (xfr#3, to-chk=26/30)
plasmid.1.protein.faa.gz
        135,747 100%  530.26kB/s    0:00:00 (xfr#4, to-chk=25/30)
plasmid.1.protein.gpff.gz
        331,121 100%  370.83kB/s    0:00:00 (xfr#5, to-chk=24/30)
plasmid.1.rna.fna.gz
          3,652 100%    4.07kB/s    0:00:00 (xfr#6, to-chk=23/30)
plasmid.1.rna.gbff.gz
          8,133 100%    8.77kB/s    0:00:00 (xfr#7, to-chk=22/30)
plasmid.2.1.genomic.fna.gz
    303,700,938 100%    1.20MB/s    0:04:02 (xfr#8, to-chk=21/30)
plasmid.2.2.genomic.fna.gz
    116,098,661 100%    2.79MB/s    0:00:39 (xfr#9, to-chk=20/30)
plasmid.2.genomic.gbff.gz
    343,969,099 100%    1.97MB/s    0:02:46 (xfr#10, to-chk=19/30)
plasmid.3.1.genomic.fna.gz
    304,120,161 100%  943.05kB/s    0:05:14 (xfr#11, to-chk=18/30)
plasmid.3.2.genomic.fna.gz
    100,498,202 100%  568.31kB/s    0:02:52 (xfr#12, to-chk=17/30)
plasmid.3.genomic.gbff.gz
    329,396,973 100%  450.57kB/s    0:11:53 (xfr#13, to-chk=16/30)
plasmid.4.1.genomic.fna.gz
    303,747,221 100%  474.68kB/s    0:10:24 (xfr#14, to-chk=15/30)
plasmid.4.2.genomic.fna.gz
    113,064,878 100%    1.40MB/s    0:01:17 (xfr#15, to-chk=14/30)
plasmid.4.genomic.gbff.gz
    341,510,422 100%    1.31MB/s    0:04:08 (xfr#16, to-chk=13/30)
plasmid.5.1.genomic.fna.gz
    161,291,365 100%    2.12MB/s    0:01:12 (xfr#17, to-chk=12/30)
plasmid.5.genomic.gbff.gz
    132,091,191 100%  626.88kB/s    0:03:25 (xfr#18, to-chk=11/30)
plasmid.5.protein.faa.gz
          8,971 100%   11.65kB/s    0:00:00 (xfr#19, to-chk=10/30)
plasmid.5.protein.gpff.gz
         16,883 100%   21.72kB/s    0:00:00 (xfr#20, to-chk=9/30)
plasmid.nonredundant_protein.1.protein.faa.gz
    137,524,098 100%    3.57MB/s    0:00:36 (xfr#21, to-chk=8/30)
plasmid.nonredundant_protein.1.protein.gpff.gz
    282,429,424 100%    6.35MB/s    0:00:42 (xfr#22, to-chk=7/30)
plasmid.nonredundant_protein.2.protein.faa.gz
    115,966,531 100%    2.69MB/s    0:00:41 (xfr#23, to-chk=6/30)
plasmid.nonredundant_protein.2.protein.gpff.gz
    261,829,661 100%    2.53MB/s    0:01:38 (xfr#24, to-chk=5/30)
plasmid.nonredundant_protein.3.protein.faa.gz
     92,394,580 100%    3.99MB/s    0:00:22 (xfr#25, to-chk=4/30)
plasmid.nonredundant_protein.3.protein.gpff.gz
    213,140,858 100%    8.44MB/s    0:00:24 (xfr#26, to-chk=3/30)
plasmid.nonredundant_protein.4.protein.faa.gz
     25,394,283 100%    4.39MB/s    0:00:05 (xfr#27, to-chk=2/30)
plasmid.nonredundant_protein.4.protein.gpff.gz
     55,526,413 100%    3.74MB/s    0:00:14 (xfr#28, to-chk=1/30)
plasmid.wgs_mstr.gbff.gz
         16,239 100%   30.32kB/s    0:00:00 (xfr#29, to-chk=0/30)

sent 658 bytes  received 4,500,522,600 bytes  744,441.86 bytes/sec
total size is 4,499,421,847  speedup is 1.00
```

csv 是逗号分隔值的意思。csv 文件是一个存储表格和电子表格信息的纯文本文件，其内容通常是一个文本、数字或日期的表格

运行perl
```
perl: warning: Setting locale failed.
perl: warning: Please check that your locale settings:
        LANGUAGE = (unset),
        LC_ALL = (unset),
        LANG = "C.UTF-8"
    are supported and installed on your system.
perl: warning: Falling back to the standard locale ("C").
解决方案
export LANGUAGE=en_US.UTF-8
export LC_ALL=en_US.UTF-8
export LANG=en_US.UTF-8
export LC_CTYPE=en_US.UTF-8
```
```
perl ~/Scripts/withncbi/taxon/gb_taxon_locus.pl genomic.gbff > refseq_id_seq.csv

运行时无gb_taxon_locus.pl文件，所以在本地建立文件，不能直接wget下载，会把整个网页下载下来，直接建立文件，把文件中的内容复制下来即可。或者在终端用vim建立本地文件，但只在当时的窗口有效，关掉就无效了

在plasimd文件下建立gb_taxon_locus.pl文件，运行
perl gb_taxon_locus.pl genomic.gbff > refseq_id_seq.csv
一直被killed
用htop查看运行状态
发现内存满了，所以被killed
解决方案：把输入文件拆分
或者for程序
for i in $(ls RefSeq/*.genomic.gbff.gz)
> do
> gzip -dcf ${i} > genomic.gbff
> perl gb_taxon_locus.pl genomic.gbff >> refseq_id_seq.csv
> rm genomic.gbff
> done

>>重定向，不会覆盖原文件，>会覆盖原文件，可以用来向文件中追加内容
```
· csv 是逗号分隔值的意思，与excel相比，只是一个文本格式，可以储存数据，但是不包括格式、公式等

refseq_id_seq.csv 内容：
```
90371	NZ_PYUR01000034
90371	NZ_PYUR01000035
90371	NZ_PYUR01000036
630	NZ_SJZK01000009
630	NZ_SJZK01000010
445983	NZ_ABCV02000004
445983	NZ_ABCV02000005
445983	NZ_ABCV02000006
445983	NZ_ABCV02000007
445983	NZ_ABCV02000008
445983	NZ_ABCV02000009
445983	NZ_ABCV02000010
445983	NZ_ABCV02000011
445983	NZ_ABCV02000013
205919	NZ_AAEQ01000061
```
3. genomic.fna 文件: FNA 文件是FASTA格式 DNA和蛋白质序列比对文件，其存储可被分子生物学软件使用的DNA信息
```
gzip -dcf RefSeq/plasmid.1.1.genomic.fna.gz |
> grep "^>" |
> head -n 5

>NZ_PYUR01000034.1 Salmonella enterica subsp. enterica serovar Typhimurium strain OLF-FSR1-ST-44 plasmid unnamed1 40, whole genome shotgun sequence
>NZ_PYUR01000035.1 Salmonella enterica subsp. enterica serovar Typhimurium strain OLF-FSR1-ST-44 plasmid unnamed1 18, whole genome shotgun sequence
>NZ_PYUR01000036.1 Salmonella enterica subsp. enterica serovar Typhimurium strain OLF-FSR1-ST-44 plasmid unnamed1 24, whole genome shotgun sequence
>NZ_SJZK01000009.1 Yersinia enterocolitica strain CFS1932 plasmid pCFS1932-1, whole genome shotgun sequence
>NZ_SJZK01000010.1 Yersinia enterocolitica strain CFS1932 plasmid pCFS1932-2, whole genome shotgun sequence
```
```
faops n50

faops n50 - compute N50 and other statistics.
usage:
    faops n50 [options] <in.fa> [more_files.fa]

options:
    -S			同时显示碱基总数
    -C			同时显示总序列数
faops n50 -S -C RefSeq/*.genomic.fna.gz
50     210996
S       5985712216
C       75816

#将*.genomic.fna.gz写入RefSeq/plasmid.fa
gzip -dcf RefSeq/*.genomic.fna.gz > RefSeq/plasmid.fa
```

**MinHash to get non-redundant plasmids**
Hash，一般翻译做散列、杂凑，是把任意长度的输入（又叫做预映射pre-image）通过散列算法变换成固定长度的输出，该输出就是散列值。简单的说就是一种将任意长度的消息压缩到某一固定长度的消息摘要的函数。

MinHash,是用于快速检测两个集合的相似性的方法。基于Jaccard相似性度量。对于两个集合X与Y，Jaccard相似性系数可以定义为：
Jaccard=X∩Y/X∪Y
该系数是0-1之间的值。当两个集合越接近，那么该值越接近1；反之，更接近0。

```
mkdir /mnt/c/shengxin/data/plasmid/nr
cd /mnt/c/shengxin/data/plasmid/nr

# 统计序列长度
faops size ../RefSeq/plasmid.fa > refseq.sizes

# 默认的字段分隔符：TSV 使用 TAB，wc 是 Word Count 的缩写，计数，-l 选项可以获得指定文件内容的行数,每行以回车键作为结尾进行统计
#筛选出refseq.sizes文件里面序列长度小于等于2000的序列，并输出行数，2:2000中的2指的是第二列
#tsv-filter命令 用于处理以制表符分隔的文件（TSV格式） 具体用法见https://github.com/eBay/tsv-utils/blob/master/docs/tool_reference/tsv-filter.md

tsv-filter refseq.sizes --le 2:2000 | wc -l

9477
```

补充:
-eq(equal) 相等

-ne(inequality) 不相等

-gt(greater than) 大于

-lt(less than) 小于

-ge(greater equal) 大于或等于

-le(less equal) 小于或等于

```
# some根据列表提取特定序列，<表示输入重定向，把长度大于2000的序列提取到refseq.fa文件中

#筛选并得到序列长度大于2000的序列，提取到refseq.fa文件中
faops some ../RefSeq/plasmid.fa <(tsv-filter refseq.sizes --gt 2:2000) refseq.fa

# 将reads打断成更小的k-mers
# 通过构建草图（sketching）节省运行时间
# Mash: 使用MinHash快速估算基因距离
mash的两个基本功能：sketch 功能将序列转化为哈希结构图。 dist 功能比对 序列之前的sketches结果并且返回 Jaccard index的估计值,P值, 还有Mash距离, 这些值能用于估计一个简单进化模型的序列突变率。

 [mash sketch用法](https://www.venea.net/man/mash-sketch(1)) 
# K-mer是指将reads迭代分成包含K个碱基的序列，一般长短为L的reads可以分成L-K+1个k-mers。K-mer可以用于基因组从头组装前的基因组调查，评估基因组的大小。
# -k 21: K-mer 大小为21；k-mers是包含在生物序列中的长度为k的子序列, -k 21:序列中的长度为21的子序列
# -s 1000 每个sketch草图最多有1000个非冗余最小哈希； 
# -i 绘制单个序列而不是整个文件，即k-mer打断的时候以序列为单位，而不是把整个文件混在一起打断；
# -p 8 多线程处理;-o 设置名称前缀；# -: read from standard input

cat refseq.fa |
    mash sketch -k 21 -s 1000 -i -p 8 - -o refseq.plasmid.k21s1000.msh

# split 将总dna序列分成65个小文件
mkdir -p job
faops size refseq.fa |
    cut -f 1 |
    split -l 1000 -a 3 -d - job/
#cut 在处理多空格间隔的域时，比较麻烦，它擅长处理以一个字符间隔的文本内容
cut -f，以域（fileds）为单位进行分割，cut -f 1第一个域，-f 1，3，第1-3个连续的域
#split命令用于将一个文件分割成数个。在默认情况下将按照每1000行切割成一个小文件。
split [--help][--version][-<行数>][-b <字节>][-C <字节>][-l <行数>][要切割的文件][输出文件名]
#-l, -<行数> : 指定每多少行切成一个小文件
#-a, –suffix-length=N 使用长度为 N 的后缀 (默认 2) 
#-d，–numeric-suffixes 使用数字后缀代替字母 ，以0开始
# 每个输出文件1000行，生成长度为3[0--]的后缀，(使用从 0 开始的数字后缀，而不是字母)

ls

000  003  006  009  012  015  018  021  024  027  030  033  036  039  042  045  048  051  054  057  060  063  066
001  004  007  010  013  016  019  022  025  028  031  034  037  040  043  046  049  052  055  058  061  064
002  005  008  011  014  017  020  023  026  029  032  035  038  041  044  047  050  053  056  059  062  065
#结果，经过处理，分成了67个文件

# 将原本大的总dna分成小文件排序并且分别划分成21-kmers
find job -maxdepth 1 -type f -name "[0-9]??" | sort |
    parallel -j 4 --line-buffer '
        echo >&2 "==> {}"
        faops some refseq.fa {} stdout |
            mash sketch -k 21 -s 1000 -i -p 6 - -o {}.msh
    '
#--max-depth=n表示只深入到第n层目录，-maxdepth 1 查找当前目录，-maxdepth 1 查找当前目录；find 命令会搜索常规文件，但最好进行指定（-type f）以使所有内容更清晰；-name "[0-9]??"：查找以0-9数字开头的文件
#sort：排序。将文件的每一行作为一个单位，相互比较，比较原则是从首字符向后，依次按ASCII码值进行比较，最后将他们按升序输出。
#line-buffer：Windows输出过程是处理完一部分一次性输出一大段，该语句使得处理了一部分就输出一点，运行过程一直有序输出
#>&2，&是文件描述符，&2 表示错误通道2，>&2 表示hello 重定向输出到错误通道2，即终端屏幕上显示。0（stdin，标准输入）、1（stdout，标准输出）、2（stderr，标准错误输出）
#some按照提供的序列名列表提取指定的序列


# 看两基因组之间的距离,相当于所有的质粒序列两两相互比对
#当Jaccard指数在大于0< j ≤1时，j 越大也即二者相近kmer越多，最终得到的mash距离越小，两个基因组越相近
#Mash distance(D)，取值0-1，越小两个基因组序列越相近，越大则二者越远

find job -maxdepth 1 -type f -name "[0-9]??" | sort |
    parallel -j 4 --line-buffer '
        echo >&2 "==> {}"
        mash dist -p 6 {}.msh refseq.plasmid.k21s1000.msh > {}.tsv
    '
如果单个跑的话，程序是
cd /mnt/c/shengxin/data/plasmid/nr/job/
mash dist -p 6 026.msh ../refseq.plasmid.k21s1000.msh > 026.tsv

# 筛选出distance < 0.01，即非常相似的序列
#tsv-filter --ff两两文件比较，--ff-str-ne FIELD1:FIELD2 - FIELD1 != FIELD2 (string). FIELD1 != FIELD2(字符串)。！=表示不等于
--le 3:0.01 第三列小于0.01
find job -maxdepth 1 -type f -name "[0-9]??" | sort |
    parallel -j 16 '
        cat {}.tsv |
            tsv-filter --ff-str-ne 1:2 --le 3:0.01
    ' \
    > redundant.tsv

cat redundant.tsv | head -n 10 
NZ_JAGFJR010000041.1    NZ_JAGEOP010000052.1    0.000336872     0       986/1000
NZ_JAGEOP010000052.1    NZ_JAGFJR010000041.1    0.000336872     0       986/1000
NZ_SINY01000002.1       NZ_SIQB01000002.1       0.00454897      0       833/1000
NZ_SIPR01000003.1       NZ_SIQB01000003.1       0.000167546     0       993/1000
NZ_SINY01000004.1       NZ_SIQB01000004.1       0.00705245      0       758/1000
NZ_SIQA01000006.1       NZ_SIQB01000006.1       0.000981871     0       960/1000
NZ_SIQO01000007.1       NZ_SIQB01000006.1       0.00146992      0       941/1000
NZ_SIPR01000006.1       NZ_SIQB01000006.1       0.00969064      0       689/1000
NZ_SIQN01000006.1       NZ_SIQB01000006.1       0.000931334     0       962/1000
NZ_SIOD01000006.1       NZ_SIQB01000006.1       0.00105797      0       957/1000

cat redundant.tsv | wc -l
1804171

. join()：将序列（也就是字符串、元组、列表、字典）中的元素以指定的字符连接生成一个新的字符串。
\t ：表示空4个字符，类似于文档中的缩进功能，相当于按一个Tab键。\n ：表示换行
#-M 引用模;-n 循环,一行一行来处理文件;-l 参数表示自动去除行尾的换行符;-a 参数表示按照指定分隔符（\t）将每行数据分割成数组 @F(缺省参数,是在声明函数的某个参数的时候为之指定一个默认值，在调用该函数的时候如果采用该默认值，你就无须指定该参数)；-F 修改分离符;-e 一行程序
#Graph::Undirected模代表无向图，可以将三至更多的最短关系计算出来
#qq{ }	为字符串添加双引号
g	替换所有匹配的字符串
#->	箭号用于指定一个类的方法
cat redundant1.tsv |
    perl -nla -F"\t" -MGraph::Undirected -e ' 
#创建了一个名为 $g 的无向图对象  
            BEGIN {
            our $g = Graph::Undirected->new;
        }

        $g->add_edge($F[0], $F[1]); #对于每一行输入数据，将第一列和第二列作为顶点，使用 $g->add_edge() 方法将它们添加到图中

        END {
            for my $cc ( $g->connected_components ) {
                print join qq{\t}, sort @{$cc}; 
            }#使用 $g->connected_components 获取图中的连通分量
        }
    ' \
    > connected_components.tsv

#将每一个相似质粒序列依次列出来
cat connected_components.tsv |
    perl -nla -F"\t" -e 'printf qq{%s\n}, $_ for @F' \
    > components.list
  #%s 输出字符串

wc -l connected_components.tsv components.list
   6253 connected_components.tsv
  41611 components.list
  47864 total
  序列一共四万多条，相似的共4万条，只保留单一的六千多条即可

faops some -i refseq.fa components.list stdout > refseq.nr.fa #-i 提取的是list中不含有的序列
faops some refseq.fa <(cut -f 1 connected_components.tsv) stdout >> refseq.nr.fa #再把redundant的序列集中挑第一个再补充加进去

#rm -rf 删除当前目录下的所有文件及目录，并且是直接删除，无需逐一确认命令行为
rm -fr job

#统计现在序列行数
cat  refseq.nr.fa | grep '>' | wc -l（是小写L，不是1）
30981
```
## Grouping by MinHash
```
mkdir /mnt/c/shengxin/data/plasmid/grouping
cd /mnt/c/shengxin/data/plasmid/grouping

# 给非冗余质粒序列建k-mer
cat ../nr/refseq.nr.fa |
    mash sketch -k 21 -s 1000 -i -p 8 - -o refseq.nr.k21s1000.msh

# split将非冗余序列名称分别储存在30个小文件中
mkdir -p job # -p 确保目录名称存在，不存在的就建一个
faops size ../nr/refseq.nr.fa |
    cut -f 1 |
    split -l 1000 -a 3 -d - job/

# 给每个非冗余序列建k-mer文件
find job -maxdepth 1 -type f -name "[0-9]??" | sort |
    parallel -j 4 --line-buffer '
        echo >&2 "==> {}"
        faops some ../nr/refseq.nr.fa {} stdout |
            mash sketch -k 21 -s 1000 -i -p 6 - -o {}.msh
    '

# 将每个非冗余序列小msh文件分别和总的非冗余序列msh文件比对
find job -maxdepth 1 -type f -name "[0-9]??" | sort |
    parallel -j 4 --line-buffer '
        echo >&2 "==> {}"
        mash dist -p 6 {}.msh refseq.nr.k21s1000.msh > {}.tsv
    '

# 将得到的比对结果合并为一个文件
find job -maxdepth 1 -type f -name "[0-9]??" | sort |
    parallel -j 6 '
        cat {}.tsv
    ' \
    > dist_full.tsv

# distance < 0.05
cat dist_full.tsv |
    tsv-filter --ff-str-ne 1:2 --le 3:0.05 \
    > connected.tsv

head -n 5 connected.tsv
NZ_CP014966.1   NZ_JAGEOP010000044.1    0.0397669       0       277/1000
NZ_OM311153.1   NZ_JAGJVE010000023.1    0.0363341       0       304/1000
NZ_JRKV01000052.1       NZ_JAGMUW010000160.1    0.0466675       0       231/1000
NC_024969.1     NZ_LGYC01000043.1       0.0455159       0       238/1000
NZ_JAJQQO010000008.1    NZ_LJCD01000031.1       0.0228571       0       448/1000

cat connected.tsv | wc -l
344446

mkdir -p group
cat connected.tsv |
    perl -nla -F"\t" -MGraph::Undirected -MPath::Tiny -e '
    #Path::Tiny 文件路径实用程序；-e 参数后面跟着实际的 Perl 代码
        BEGIN {
            our $g = Graph::Undirected->new;
        }

        $g->add_edge($F[0], $F[1]);  #边界设定为比较的两个序列
#定义了空数组 @rare，用于存放稀缺的顶点；定义了一个变量 $serial，用于给每个组分配唯一的序号
        END {
            my @rare;
            my $serial = 1;
            my @ccs = $g->connected_components;
            @ccs = map { $_->[0] }  
            #如果返回值存储在list中，map()函数返回数组
            # @ccs中储存了对比的第一个序列的名称

            sort { $b->[1] <=> $a->[1] }  #将第二个序列从小到大排列
            map { [ $_, scalar( @{$_} ) ] } @ccs;
            #如果返回值存储在scalar标量中，则代表map()返回数组的元素个数；返回ccs

            for my $cc ( @ccs ) {
                my $count = scalar @{$cc};
                if ($count < 50) {
                    push @rare, @{$cc};  # push可向数组的末尾添加一个或多个元素，并返回新的长度
                }
                else {
                    path(qq{group/$serial.lst})->spew(map {qq{$_\n}} @{$cc});
                    $serial++;  #连通分量数组 @ccs。首先，计算连通分量内的顶点数量。如果数量小于 50，则将这些顶点添加到 @rare 数组中。否则，将这些顶点存储到以 $serial 命名的文件中，并递增 $serial 的值
                }
            }
            path(qq{group/00.lst})->spew(map {qq{$_\n}} @rare);
            # 将 @rare 数组中的顶点写入名为 "group/00.lst" 的文件中
            path(qq{grouped.lst})->spew(map {qq{$_\n}} $g->vertices);#将整个无向图中的所有顶点写入名为 "grouped.lst" 的文件中
        }
    '
## $a<=>$b;
# 等价于下面三行∶
# if($a<$b){return -1;}
# elsif($a==$b){return 0;}
# elsif($a>$b){return 1;}      
# ‘->’符号是“插入式解引用操作符”（infix dereference operator）。 换句话说，它是调用由引用传递参数的子程序的方法。
#map函数：map EXPR LIST，对list中的每个元素执行EXPR或BLOCK，返回新的list。对每一此迭代，$_中保存了当前迭代的元素的值。
$_(下划线) 表示的是打印上一个输入参数行，当这个命令在开头时，打印输出文档的绝对路径名

# get non-grouped
# this will no be divided to subgroups
faops some -i ../nr/refseq.nr.fa grouped.lst stdout |
    faops size stdin |
    cut -f 1 \
    > group/lonely.lst

# 这几个序列关系：
# 00.lst储存rare序列，很少和其他序列差异比较大；
# 1-9.lst存储出现次数大于等于50的序列，容易和其他序列差异比较大；
# grouped.lst等于connected.tsv，distance < 0.05；
# lonely.lst等于refseq.nr.fa减去grouped.lst（connected.tsv），和其他序列差异比较小。

wc -l group/*.lst
  7319 group/00.lst
    60 group/10.lst
    57 group/11.lst
    57 group/12.lst
    56 group/13.lst
    53 group/14.lst
  9306 group/1.lst
   282 group/2.lst
   222 group/3.lst
   106 group/4.lst
    95 group/5.lst
    78 group/6.lst
    75 group/7.lst
    63 group/8.lst
    62 group/9.lst
 13105 group/lonely.lst
 30996 total
 
# 每一个lst中序列再互相比对
find group -maxdepth 1 -type f -name "[0-9]*.lst" | sort |
    parallel -j 4 --line-buffer '
        echo >&2 "==> {}"

        faops some ../nr/refseq.nr.fa {} stdout |
            mash sketch -k 21 -s 1000 -i -p 6 - -o {}.msh

        mash dist -p 6 {}.msh {}.msh > {}.tsv
    '

# 对.lst.tsv-分别建树，并把每个树的分组分别存储在{.}.groups.tsv文件中

find group -maxdepth 1 -type f -name "[0-9]*.lst.tsv" | sort |
    parallel -j 4 --line-buffer '
        echo >&2 "==> {}"

        cat {} |
            tsv-select -f 1-3 |
            #TSV-SELECT 读取文件或标准输入，并将所选字段写入标准输出。字段按列出的顺序写入.--f|fields <field-list>- 要保留的字段。字段按列出的顺序输出。
            Rscript -e '\''
                library(readr);读取矩形文本数据•阅读器
                library(tidyr);类似Excel中数据透视表
                library(ape);系统发育与进化分析(ape)包含了很多序列和进化树的操作
            #read_tsv 函数读取标准输入中的数据，并命名为 pair_dist。该数据包含两列，分别表示顶点对和对应的距离。
                pair_dist <- read_tsv(file("stdin"), col_names=F);#file是一个带分隔符的ASCII文本文件，col_names列向量
                tmp <- pair_dist %>%
            #将顶点对作为列名，距离作为值，并用默认值 1.0 填充缺失值。
                    pivot_wider( names_from = X2, values_from = X3, values_fill = list(X3 = 1.0) )
                    #用%>%来强调操作序列，pivot_wider()函数可用于将数据帧从长格式转换为宽格式
            #将转换后的数据转换为矩阵，去除第一列，并将第一列作为行名
                tmp <- as.matrix(tmp)#tmp临时文件
                mat <- tmp[,-1]#mat构造二维向量
                rownames(mat) <- tmp[,1]#rownames，行名称

                dist_mat <- as.dist(mat)#as.dist 函数将矩阵转换为距离矩阵
                clusters <- hclust(dist_mat, method = "ward.D2")#hclust 函数基于距离矩阵进行层次聚类，并选择 "ward.D2" 方法-ward离差平方和法,
            #将聚类结果转换为基本树结构，并使用 write.tree 函数将树写入以文件名为基础的 ".tree.nwk" 文件;phylo的本质是list，包括进化树末端分类单元名称（tip label），枝长（edge length）等
                tree <- as.phylo(clusters)
                write.tree(phy=tree, file="{.}.tree.nwk")

                group <- cutree(clusters, h=0.2) #cutree 函数将聚类结果划分为若干组，阈值参数设置为 0.2
                groups <- as.data.frame(group)#将划分结果转换为数据框
                groups$ids <- rownames(groups)#并添加一列作为顶点标识符
                rownames(groups) <- NULL
                groups <- groups[order(groups$group), ]
                write_tsv(groups, "{.}.groups.tsv")
            '\''
    '
运行中出现问题
Error in library(readr) : there is no package called ‘readr’
Execution halted
解决方案
1.首先在R里面安装
install.packages("BiocManager")
BiocManager::install("readr", force = TRUE)
library(readr)
Warning message:
程辑包‘readr’是用R版本4.2.3 来建造的 ，更新R
卸载旧版本，安装新的4.3.1
出现问题，linux下无法调用最新的R4.3.1，一直调用的是R4.2.2.因为下载的是windows的R，与ubuntu里面的R4.2.2不一样
2.始终在终端里安装（正确的）
brew uninstall R
source ~/.bashrc #source命令通常用于重新执行刚修改的初始化文件，使之立即生效，而不必注销并重新登录
R
sudo apt install r-base r-base-dev #Installing R in Ubuntu，apt 命令：查找、安装、升级、删除某一个、一组甚至全部软件包
R #检查版本是否正确，此时相当于进入到R里面，输入符号是>，
> install.packages("readr")
>library(readr)
q()#退出R

# subgroup
mkdir -p subgroup
cp group/lonely.lst subgroup/

find group -name "*.groups.tsv" | sort |
    parallel -j 1 -k ' #--keep-order/-k   强制使输出与参数保持顺序 --keep-order/-k
        cat {} | sed -e "1d" | xargs -I[] echo "{/.}_[]"
        # sed主要是以行为单位进行处理，可以将数据行进行替换、删除、新增、选取等特定工作.sed -e 多次编辑不需要管道符;删除第一行的列名。d代表删除 d前面的数字代表删除第一行，该命令不会修改文件本身
        # xargs 是一个强有力的命令，它能够捕获一个命令的输出，然后传递给另外一个命令，适用于不适合用管道符的命令。规定命名方法 例：{}=group/1.lst.groups.tsv；i 或者是-I，将xargs的每项名称，一般是一行一行赋值给 {}，可以用 {} -代替，I[]从标准读取的名称=每一个聚类的序号；{/.}=1.lst.groups；{/.}_[]=1.lst.groups_1
    ' |
    sed -e 's/.lst.groups_/_/' |  #s ：取代，即1_1
    perl -na -F"\t" -MPath::Tiny -e '
        path(qq{subgroup/$F[0].lst})->append(qq{$F[1]});
    '

# ignore small subgroups 删掉了 一个簇中少于5个枝的簇，放在lonely.lst中
find subgroup -name "*.lst" | sort |
    parallel -j 1 -k '
        lines=$(cat {} | wc -l)

        if (( lines < 5 )); then  #(( ... ))可以执行算数相当于[[]]
            echo -e "{}\t$lines"
            cat {} >> subgroup/lonely.lst
            rm {}
        fi
    '
# append ccs 将重复的序列也保存subgroup中
cat ../nr/connected_components.tsv |
    parallel -j 1 --colsep "\t" '#-colsep把行切分成列
        file=$(rg -F -l  "{1}" subgroup)
        echo {} | tr "[:blank:]" "\n" >> ${file}
    '
# rg: 递归地在当前目录中搜索匹配模式的行，比grep更高级
# -F/--fixed-strings：将模式视为文字字符串而不是正则表达式
# -l/--file-with-matches: 打印至少有一个匹配的路径并抑制匹配内容
# tr: 将标准输入复制到标准输出，替换或删除所选字符
# "[:blank:]": 所有水平空格 - POSIX 基本正则表达式

# remove duplicates 因为上一步将所有相关序列名称都放入${file}会有重复，下一步去重
find subgroup -name "*.lst" | sort |
    parallel -j 1 '
        cat {} | sort | uniq > tmp.lst #uniq 可检查文本文件中重复出现的行列
        mv tmp.lst {} #将去重的文件覆盖原来的
    '

wc -l subgroup/* |
    sort -nr |
    head -n 100
 47162 total
 23113 subgroup/lonely.lst
   486 subgroup/00_432.lst
   420 subgroup/00_1401.lst
   377 subgroup/00_514.lst
···
    47 subgroup/00_1201.lst
    46 subgroup/13_2.lst
    46 subgroup/10_8.lst
    46 subgroup/00_825.lst
    46 subgroup/00_666.lst
    45 subgroup/00_9.lst
    
# 根据制表符分隔的文件的第一个字段的值，筛选出值小于等于10的行
wc -l subgroup/* |
    perl -pe 's/^\s+//' |#-P 假设像-n一样的循环，但也打印行，像sed；替换：s///，^匹配字符开头的字符，\s+和 [\n\t\r\f]+ 一样
    tsv-filter -d" " --le 1:10 |#-d 分隔符
    wc -l
419

#，对子目录中的文件进行处理，统计行数后删除前导空格，然后筛选出第一个字段大于等于50的行，并且第二个字段以2开头并且后面跟着一个或多个数字的行，最后按照数字逆序排序，并将结果保存在next.tsv文件中
wc -l subgroup/* |
    perl -pe 's/^\s+//' |
    tsv-filter -d" " --ge 1:50 |#ge 数字，即筛选大于等于50的簇
    tsv-filter -d " " --regex '2:\d+' |#regex，与正则表达式相符。--regex '2:\d+'，筛选出第二个字段的值满足正则表达式2:\d+的行，即第二个字段以2开头并且后面跟着一个或多个数字
    sort -nr \
    > next.tsv

wc -l next.tsv
84

# rm -fr job
```
## Plasmid: prepare
- Split sequences
```
mkdir /mnt/c/shengxin/data/plasmid/GENOMES
mkdir /mnt/c/shengxin/data/plasmid/taxon #taxon 分类单元

cd /mnt/c/shengxin/data/plasmid/grouping

# 给文件内容加标题
echo -e "#Serial\tGroup\tCount\tTarget" > ../taxon/group_target.tsv #\t制表符分隔

cat next.tsv |
    cut -d" " -f 2 |# 分隔符为空格，只打印指定的第二行，得到*.lst文件
    # 下面分别打开每一个.lst文件，得到
    # NC_002122.1
    # NC_019083.1
    # NC_006671.1
    # NC_008612.1

    parallel -j 4 -k --line-buffer '
        echo >&2 "==> {}"

        GROUP_NAME={/.}  
        #等于subgroup/00_27.lst去掉目录和后缀，即00_27
        TARGET_NAME=$(head -n 1 {} | perl -pe "s/\.\d+//g")   # 去掉NC_002122.1的.后面的数字

        SERIAL={#}
        COUNT=$(cat {} | wc -l)

        echo -e "${SERIAL}\t${GROUP_NAME}\t${COUNT}\t${TARGET_NAME}" >> ../taxon/group_target.tsv
        
        #将每个lst中储存的序列提取出来，
        faops order ../nr/refseq.fa {} stdout |# order重排序
            faops filter -s stdin stdout \  #-s 简化序列名称
            > ../GENOMES/${GROUP_NAME}.fa  #每一个成簇的序列放在一个文件中，文件名为00_27.fa
    '

# taxon文件夹中储存着每一个簇的每个序列的大小
cat next.tsv |
    cut -d" " -f 2 |
    parallel -j 4 -k --line-buffer '
        echo >&2 "==> {}"
        GROUP_NAME={/.}
        faops size ../GENOMES/${GROUP_NAME}.fa > ../taxon/${GROUP_NAME}.sizes
    '
# 使用 RepeatMasker 软件对 GENOMES 目录下的所有 .fa 文件进行屏蔽重复序列分析的命令
# Optional: RepeatMasker #RepeatMasker 用于识别和屏蔽基因组中的重复元素和转座子。它可以帮助研究人员在基因组分析中减少干扰和噪音，从而更好地理解基因组的结构和功能。
#egaz repeatmasker -p 16 ../GENOMES/*.fa -o ../GENOMES/

# split-name   命令faops split-name 可以按序列名称对序列文件进行切割. 
find ../GENOMES -maxdepth 1 -type f -name "*.fa" | sort |
    parallel -j 4 '
        faops split-name {} {.}  # 输出文件夹名称去掉.fa，即00_27
    '

# 给每个单独的序列建文件夹
# mv to dir of basename
find ../GENOMES -maxdepth 2 -mindepth 2 -type f -name "*.fa" | sort |
    parallel -j 4 '
        mkdir -p {.}#使用文件路径创建一个同名的目录
        mv {} {.} #将找到的文件移动到相应的目录中
    '

```
- prepseq
``` 
cd /mnt/c/shengxin/data/plasmid
cat taxon/group_target.tsv |
    sed -e '1d' | #删除第一行
    parallel --colsep '\t' --no-run-if-empty --linebuffer -k -j 4 ' #-colsep把行切分成列
        echo -e "==> Group: [{2}]\tTarget: [{4}]\n"

        for name in $(cat taxon/{2}.sizes | cut -f 1); 
        do #cat taxon/00_27.sizes 是每一个簇中具体的每个序列+序列碱基数 | 只提取序列名称NC_001496等 
            egaz prepseq GENOMES/{2}/${name} 
             #GENOMES/00_27/NC_001496
        done
    '
#prepseq: preparing steps for lastz#lastz对两条DNA序列进行比对
```
- Check outliers of lengths 检查长度的异常值
```
cd /mnt/c/shengxin/data/plasmid
cat taxon/*.sizes | cut -f 1 | wc -l
8214

#用于计算taxon 目录下多个文件中的第二个字段的数值的总和
cat taxon/*.sizes | cut -f 2 | paste -sd+ | bc
#paste 指令会把每个文件以列对列的方式，一列列地加以合并；-d<间隔字，用指定的间隔字符取代跳格字符。-s或--serial 　串列进行而非平行处理；paste -sd+：将切割后的每行数字使用加号连接起来。
#bc：通过 bc 命令执行基本计算，类似于计算器
922851803

cat taxon/*.sizes | cut -f 2 | paste -sd+ | head -n 5
48125+300837+333311+340708+284751+270906+259080+255232+283930+398857+311749+306131+256887+201182+268263+355358+327867+206931+369925+283349+248123···

#在 taxon 目录下筛选出小于等于较低限制值的行，并将筛选后的结果保存回原始文件中
cat taxon/group_target.tsv |
    sed -e '1d' |
    parallel --colsep '\t' --no-run-if-empty --linebuffer -k -j 4 ' #-k 用于保持输出的顺序
        echo -e "==> Group: [{2}]\tTarget: [{4}]"

        median=$(cat taxon/{2}.sizes | datamash median 2)  #计算当前组文件 {2}.sizes 中第2列的中位数；atamash 作为一个命令行程序可以对文本文件进行数字和文本相关的基本统计操作
        mad=$(cat taxon/{2}.sizes | datamash mad 2) #mad绝对偏差中位数；计算当前组文件 {2}.sizes 中第2列的MAD
        lower_limit=$( bc <<< " (${median} - 2 * ${mad}) / 2" )  #低限度值

#        echo $median $mad $lower_limit
        lines=$(tsv-filter taxon/{2}.sizes --le "2:${lower_limit}" | wc -l)  #筛选出序列长度小于等于低限度值的行，计算序列数目

        if (( lines > 0 )); then
            echo >&2 "    $lines lines to be filtered"
            tsv-join taxon/{2}.sizes -e -f <(

            #--e|exclude - Exclude matching records.
            #--f|filter-file FILE - (Required) File with records to use as a filter.

                    tsv-filter taxon/{2}.sizes --le "2:${lower_limit}"
                ) \
                > taxon/{2}.filtered.sizes
            mv taxon/{2}.filtered.sizes taxon/{2}.sizes#将过滤完的序列覆盖原有序列
        fi
    '
cat taxon/*.sizes | cut -f 1 | wc -l
6600
cat taxon/*.sizes | cut -f 2 | paste -sd+ | bc
921980223

Rsync to hpcc
rsync -avP \
    ~/data/plasmid/ \
    wangq@202.119.37.251:data/plasmid
该命令将本地计算机上 ~/data/plasmid/ 目录下的文件同步到 HPCC 的 wangq@202.119.37.251:data/plasmid 目录中

# rsync -avP wangq@202.119.37.251:data/plasmid/ ~/data/plasmid
该命令将 HPCC 上的 wangq@202.119.37.251:data/plasmid 目录下的文件同步到本地计算机的 ~/data/plasmid/ 目录中
```
- Plasmid: run
```
cd /mnt/c/shengxin/data/plasmid
#根据 taxon/group_target.tsv 中的每一行，生成模板文件并将其中的两个任务提交给 MPI 队列执行
cat taxon/group_target.tsv |
    sed -e '1d' | grep "^53" |#通过 grep 命令筛选出以 53 开头的行
    parallel --colsep '\t' --no-run-if-empty --linebuffer -k -j 1 '
        echo -e "==> Group: [{2}]\tTarget: [{4}]\n"

# 根据给定的路径模板和一组输入文件的路径，生成相应的模板文件，并将输出文件保存在 groups/{2}/ 目录中
        egaz template \
            GENOMES/{2}/{4} \#指定一个路径模板，其中 {2} 和 {4} 分别是变量，代表 taxon/group_target.tsv 文件中的第二列和第四列的值。这个路径模板将用于生成输入文件的路径
            $(cat taxon/{2}.sizes | cut -f 1 | grep -v -x "{4}" | xargs -I[] echo "GENOMES/{2}/[]") \
            #grep -v：反向查找，只打印不匹配的行；x 只显示全列符合的列；grep -v -x "{4}" 筛选出不等于 {4} 的值
            --multi -o groups/{2}/ \#指定输出目录为 groups/{2}/，并使用 --multi 参数表示生成多个输出文件
            --order \#保持输入文件的顺序
            --parallel 24 -v #最大并行任务数为 24；-v：输出详细的运行日志信息

#        bash groups/{2}/1_pair.sh
#        bash groups/{2}/3_multi.sh

        bsub -q mpi -n 24 -J "{2}-1_pair" "bash groups/{2}/1_pair.sh"#使用 bsub 命令将 bash groups/{2}/1_pair.sh 提交给 MPI 队列执行，MPI是一套通信标准
#egaz 后端简单的基因组比对；template:用于创建bash执行文件
#bsub，提交给lsf作业的命令。-q 选择队列；-q mpi：指定队列为 MPI 队列，表示提交给 MPI 并行计算集群来执行任务；-n 24 指定使用的进程数为 24；-J 作业的名字
#LSF（Load Sharing Facility）是IBM旗下的一款分布式集群管理系统软件，负责计算资源的管理和批处理作业的调度

#将 bash groups/{2}/3_multi.sh 脚本提交给 MPI 队列，等待依赖任务 {2}-1_pair 结束后执行，并使用 24 个并行处理器执行任务
#-w  提交作业前，指定操作。即等待任务 {2}-1_pair 结束后再提交当前任务
        bsub -w "ended({2}-1_pair)" \
            -q mpi -n 24 -J "{2}-3_multi" "bash groups/{2}/3_multi.sh"
    '
#找到满足条件的文件夹并并行地删除它们
find groups -mindepth 1 -maxdepth 3 -type d -name "*_raw" | parallel -r rm -fr
#至少深度为 1，即排除当前目录本身；最大深度为 3，即只搜索当前目录下的子目录和孙目录
#type d：类型为文件夹。使用 parallel 命令并行执行删除操作。-r 参数表示保持输入顺序

#find基本上相当于 linux下的 “搜索” , 相当于windows下的搜功能，它是用来搜索文件的
#grep(global regular expression) 命令用于查找文件里符合条件的字符串或正则表达式

find groups -mindepth 1 -maxdepth 3 -type d -name "*_fasta" | parallel -r rm -fr
find . -mindepth 1 -maxdepth 3 -type f -name "output.*" | parallel -r rm

#输出两个数字
echo \
    $(find groups -mindepth 1 -maxdepth 1 -type d | wc -l) \
    $(find groups -mindepth 1 -maxdepth 3 -type f -name "*.nwk.pdf" | wc -l)
    1 0

```




