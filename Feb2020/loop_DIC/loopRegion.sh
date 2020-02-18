
sed '1d' ../chromRegion/Rad21_manorm.bed >allCohesin.bed
cat mergeHiCloop.bedpe |sed '1d'|awk '{print "chr"$1"\t"$2"\t"$3"\t""chr"$4"\t"$5"\t"$6}'> HiC.loop

func(){
        bed=$1
        echo $bed
        pairToBed -a MCF7_RNAPII_saturated_rep1.interactions.all.mango \
        -b $bed |cut -f 9-11|sort|uniq|wc -l

        pairToBed -a MCF7_RNAPII_saturated_rep2.interactions.all.mango \
        -b $bed |cut -f 9-11|sort|uniq|wc -l

        pairToBed -a HiC.loop \
        -b $bed |cut -f 7-9|sort|uniq|wc -l
}




func allCohesin.bed
func ../chromRegion/cohesin-intra.bed
func ../chromRegion/cohesin-extra.bed
func ../chromRegion/cohesin-TSS.bed
func ../chromRegion/cohesin-TES.bed
func IC.bed
func DIC.bed
func DIC_lowCTCF.bed
func DIC_highCTCF.bed

