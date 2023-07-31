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
#tsv-filter命令 https://github.com/eBay/tsv-utils/blob/master/docs/tool_reference/tsv-filter.md

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
#-M 引用模;-n 循环,一行一行来处理文件;-l参数,用来给每一个输出加\n;-a 打开自动分离(split)模式,根据紧跟的分离号被分离然后放入缺省数组@F(缺省参数,是在声明函数的某个参数的时候为之指定一个默认值，在调用该函数的时候如果采用该默认值，你就无须指定该参数)；-F 修改分离符;-e 一行程序
#Graph::Undirected模代表无向图，可以将三至更多的最短关系计算出来
#qq{ }	为字符串添加双引号
g	替换所有匹配的字符串
#->	箭号用于指定一个类的方法
cat redundant1.tsv |
    perl -nla -F"\t" -MGraph::Undirected -e '   
            BEGIN {
            our $g = Graph::Undirected->new;
        }

        $g->add_edge($F[0], $F[1]); #此处的$F[0], $F[1]指每一行互相比对的文件

        END {
            for my $cc ( $g->connected_components ) {
                print join qq{\t}, sort @{$cc}; 
            }
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

cat connected.tsv | wc -l

mkdir -p group
cat connected.tsv |
    perl -nla -F"\t" -MGraph::Undirected -MPath::Tiny -e '
    #Path::Tiny 文件路径实用程序
        BEGIN {
            our $g = Graph::Undirected->new;
        }

        $g->add_edge($F[0], $F[1]);  #边界设定为比较的两个序列

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
                    push @rare, @{$cc};  # 出现次数很少的序列放在rare中,push可向数组的末尾添加一个或多个元素，并返回新的长度。
                }
                else {
                    path(qq{group/$serial.lst})->spew(map {qq{$_\n}} @{$cc});
                    $serial++;  # 每一个lst递增
                }
            }
            path(qq{group/00.lst})->spew(map {qq{$_\n}} @rare);
            # 00.lst是存储了rare序列
            path(qq{grouped.lst})->spew(map {qq{$_\n}} $g->vertices);
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

wc -l group/*

find group -maxdepth 1 -type f -name "[0-9]*.lst" | sort |
    parallel -j 4 --line-buffer '
        echo >&2 "==> {}"

        faops some ../nr/refseq.nr.fa {} stdout |
            mash sketch -k 21 -s 1000 -i -p 6 - -o {}.msh

        mash dist -p 6 {}.msh {}.msh > {}.tsv
    '










