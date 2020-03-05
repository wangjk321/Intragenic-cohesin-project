wget -O MCF7_FAIRE_E2_0min.hg19.bed.gz https://www.encodeproject.org/files/ENCFF001UYW/@@download/ENCFF001UYW.bed.gz

wget -O MCF7_FAIRE_E2_30min.hg19.bed.gz https://www.encodeproject.org/files/ENCFF001UYU/@@download/ENCFF001UYU.bed.gz

gunzip *gz

cut -f 1-6 MCF7_FAIRE_E2_0min.hg19.bed > E2_0min.hg19.bed
liftOver E2_0min.hg19.bed ~/dbSaxo/hg19ToHg38.over.chain MCF7_FAIRE_E2_0min.hg38.bed unlifted.bed
rm E2_0min.hg19.bed

cut -f 1-6 MCF7_FAIRE_E2_30min.hg19.bed> E2_30min.hg19.bed
liftOver E2_30min.hg19.bed ~/dbSaxo/hg19ToHg38.over.chain MCF7_FAIRE_E2_30min.hg38.bed unlifted.bed
rm E2_30min.hg19.bed



