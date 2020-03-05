 wget -qO- http://hgdownload.cse.ucsc.edu/goldenpath/hg38/database/cpgIslandExt.txt.gz \
   | gunzip -c \
   | awk 'BEGIN{ OFS="\t"; }{ print $2, $3, $4, $5$6, substr($0, index($0, $7)); }' \
   | sort-bed - \
   > cpgIslandExt.hg38.bed


 cat cpgIslandExt.txt |awk 'BEGIN{OFS="\t"}{print $2, $3, $4, $5$6,substr($0, index($0, $7)) }'|sort-bed - > cpgIsland.hg38.bed

 cat cpgIslandExt.txt |awk 'BEGIN{OFS="\t"}{print $2, $3, $4, $5$6,substr($0, index($0, $7)) }'|sort-bed - > cpgIsland.hg38.bed
