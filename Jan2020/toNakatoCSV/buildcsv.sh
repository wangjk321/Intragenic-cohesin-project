##All are based on saxophone server.

##STEP1 call peaks using "macs.sh".

Ddir=/home/Database/UCSC/hg38

post=-n2-m1-hg38
dpost=$post-raw-mpbl-GR

dir1=/work/CohesinProject/MCF7/ChIP-seq/hg38/bam

#make a peakcalling function
func(){
    ip=$1
    inp=$2

    IPbam=bam/$ip$post.sort.bam
    Inputbam=bam/$inp$post.sort.bam
    macs.sh $IPbam $Inputbam $ip sharp
}

#copy ip and input file to ./bam folder
#mkdir bam
#cp $dir1/Rad21_0min$post.sort.bam ./bam/
#cp $dir1/Rad21_45min$post.sort.bam ./bam/
#cp $dir1/CTCF_0min$post.sort.bam ./bam/
#cp $dir1/CTCF_30min$post.sort.bam ./bam/
#cp $dir1/Input_0min$post.sort.bam ./bam/
#cp $dir1/Input_30min$post.sort.bam ./bam/
#cp $dir1/Input_45min$post.sort.bam ./bam/

for IP in `ls bam/*.sort.bam | grep -v Input | sed -e 's/bam\///g' -e 's/'$post'.sort.bam//g'`
do
    
    if [ `echo $IP | grep _0min` ] ; then
        min=0min
    elif [ `echo $IP | grep _30min` ] ; then
        min=30min
    elif [ `echo $IP | grep _45min` ] ; then
        min=45min
    fi
    Input=Input_$min
    echo $IP; echo $Input
    
    #func $IP $Input
done

##STEP2 comparison of Rad21 peaks

#Here we also use the Rad21 ChIPseq data from Schimidt group.The peak calling is same with upper (script not shown).
# Use MAnorm to do "Ours_E2 vs Ours_ctrl" and "Schmidt_E2 vs Schmidt_ctrl" separately,then merge the manorm results

#2.1 comparison of our data

dir1=/work/CohesinProject/MCF7/ChIP-seq/hg38/bam
dir2=/work/CohesinProject/MCF7/ChIP-seq/hg38/macs
dir4=/work/ChIP-seq/MCF7/Schmidt/hg38/bam
dir5=/work/ChIP-seq/MCF7/Schmidt/hg38/macs

#prepare bam file for manorm 
for sample in Rad21_45min Rad21_0min
do
       bedtools bamtobed -i $dir1/$sample-n2-m1-hg38.sort.bam > $sample.bambed
done

func(){
        vs1=$1
        vs2=$2
        manorm --p1 $dir2/${vs1}_peaks.narrowPeak --p2 $dir2/${vs2}_peaks.narrowPeak --r1 $dir1/${vs1}.bam --r2 $dir1/${vs2}.bam --name1 $vs1 --name2 $vs2 -o ${vs1}_vs_$vs2
}

func Rad21_45min Rad21_0min


#2.2 comparison of Schmidt data

samtools merge -@ 32 Rad21_treat_Schimidt.bam $dir4/MCF7_Rad21_treat_rep1-n2-m1-hg38.sort.bam $dir4/MCF7_Rad21_treat_rep2-n2-m1-hg38.sort.bam
samtools merge -@ 32 Rad21_vehicle_Schimidt.bam $dir4/MCF7_Rad21_vehicle_rep1-n2-m1-hg38.sort.bam $dir4/MCF7_Rad21_vehicle_rep2-n2-m1-hg38.sort.bam

for sample in Rad21_treat_Schimidt Rad21_vehicle_Schimidt
do
       bedtools bamtobed -i $sample.bam > $sample.bambed
done

cat $dir5/MCF7_Rad21_treat_rep1-n2-m1-hg38_peaks.narrowPeak $dir5/MCF7_Rad21_treat_rep2-n2-m1-hg38_peaks.narrowPeak | sort -k1,1 -k2,2n |uniq | mergeBed -i stdin > Rad21_treat_Schimidt_peaks.narrowPeak

cat $dir5/MCF7_Rad21_vehicle_rep1-n2-m1-hg38_peaks.narrowPeak $dir5/MCF7_Rad21_vehicle_rep2-n2-m1-hg38_peaks.narrowPeak | sort -k1,1 -k2,2n |uniq | mergeBed -i stdin  > Rad21_vehicle_Schimidt_peaks.narrowPeak

func(){
        vs1=$1
        vs2=$2
        manorm --p1 ${vs1}_peaks.narrowPeak --p2 ${vs2}_peaks.narrowPeak --r1 ${vs1}.bambed --r2 ${vs2}.bambed --name1 $vs1 --name2 $vs2 -o ${vs1}_vs_$vs2
}

func Rad21_treat_Schimidt Rad21_vehicle_Schimidt

#2.3 combine the results
cat Rad21_45min_vs_Rad21_0min/Rad21_45min_vs_Rad21_0min_all_MAvalues.xls > Rad21_manorm.bed.temp
sed '1d' Rad21_treat_Schimidt_vs_Rad21_vehicle_Schimidt/Rad21_treat_Schimidt_vs_Rad21_vehicle_Schimidt_all_MAvalues.xls >> Rad21_manorm.bed.temp

cat Rad21_manorm.bed.temp |sort -k1,1 -k2,2n > Rad21_manorm.bed
rm Rad21_manorm.bed.temp

#The file Rad21_manorm.bed is our final comparison results, and "MValue" column is log2 fold change of Rad21 peak density (E2 vs Ctrl)

##STEP3 intersect with CTCF peaks

#Here we simply use the bedtools to overlap CTCF peaks. When we define CTCF-dependent DIC, we used CTCF peak density on DIC sites to classify ctcf/non-ctcf cohesin (There is a negative correlation between CTCF and TFs in DIC sites, so we can find the thereshold of ctcf density easily. But not for all cohesin sites here. So we simply overlap Cohesin with CTCF use bedtools).

sed '1d' ./manorm/Rad21_manorm.bed > Rad21.bed
cat ./peaks/CTCF_0min_peaks.narrowPeak ./peaks/CTCF_30min_peaks.narrowPeak | sort -k1,1 -k2,2n| mergeBed -i stdin |uniq > CTCF.bed

intersectBed -u -a Rad21.bed -b CTCF.bed > Rad21_withCTCF.bed
intersectBed -v -a Rad21.bed -b CTCF.bed > Rad21_nonCTCF.bed

##STEP4 export position to csv

awk '{print $1"-"$2"-"$3}' Rad21.bed > Rad21_all.position
awk '{print $1"-"$2"-"$3}' CTCF.bed > CTCF_all.position
awk '{print $1"-"$2"-"$3}' Rad21_withCTCF.bed > Rad21_withCTCF.position
awk '{print $1"-"$2"-"$3}' Rad21_nonCTCF.bed > Rad21_nonCTCF.position
touch blank.position
awk '{print $1"-"$2"-"$3}' ./peaks/Rad21_0min_peaks.narrowPeak > Rad21_0min_ours.position
awk '{print $1"-"$2"-"$3}' ./peaks/Rad21_45min_peaks.narrowPeak > Rad21_45min_ours.position
awk '{print $1"-"$2"-"$3}' ./peaks/Rad21_treat1_Schmidt.narrowPeak > Rad21_treat1_Schmidt.position
awk '{print $1"-"$2"-"$3}' ./peaks/Rad21_treat2_Schmidt.narrowPeak > Rad21_treat2_Schmidt.position
awk '{print $1"-"$2"-"$3}' ./peaks/Rad21_vehicle1_Schmidt.narrowPeak > Rad21_vehicle1_Schmidt.position
awk '{print $1"-"$2"-"$3}' ./peaks/Rad21_vehicle2_Schmidt.narrowPeak > Rad21_vehicle2_Schmidt.position

paste Rad21_all.position CTCF_all.position Rad21_withCTCF.position Rad21_nonCTCF.position blank.position Rad21_0min_ours.position Rad21_45min_ours.position Rad21_treat1_Schmidt.position Rad21_treat2_Schmidt.position Rad21_vehicle1_Schmidt.position Rad21_vehicle2_Schmidt.position | sed '1i Rad21\tCTCF\tRad21_withCTCF\tRad21_nonCTCF\t\tRad21_0min_ours\tRad21_45min_ours\tRad21_treat1_Schmidt\tRad21_treat2_Schmidt\tRad21_vehicle1_Schmidt\tRad21_vehicle2_Schmidt' >Rad21_CTCF.csv

rm *position






