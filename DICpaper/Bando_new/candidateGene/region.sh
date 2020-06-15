dirDB=/home/wang/dbSaxo
end="-n2-m1-hg38-raw-mpbl-GR"
dir1=/work/CohesinProject/MCF7/ChIP-seq/hg38/parse2wigdir
dir2=/work/WangData/Bando_new_DIC/parse2wigdir

drompa_draw PC_SHARP -p newPol2 -gene $dirDB/refFlat.dupremoved.txt \
        -gt $dirDB/genometable_all.txt -lpp 2 -ls 200 -scale_tag 15\
        -r ~/DIC/Bando_new/DIPol2/newDIgene.bed -nosig -bn 1 -viz 0 -offbg \
	-i $dir1/Rad21_0min$end,,Rad21_ctrl,,,40 \
	-i $dir1/Rad21_45min$end,,Rad21_E2,,,40 \
	-i $dir1/Pol2_0min$end,,Pol2_ctrl,,,40 \
        -i $dir1/Pol2_45min$end,,Pol2_E2,,,40 \
	-i $dir2/Con_RNAPII$end,$dir2/Con_Input$end,newPol2_ctrl,,,40 \
        -i $dir2/Con_E2_RNAPII$end,$dir2/Con_E2_Input$end,newPol2_E2,,,40 \
	-i $dir2/Con_DRB_RNAPII$end,$dir2/Con_DRB_Input$end,newPol2_DRB,,,40 \
	-i $dir2/Con_E2_DRB_RNAPII$end,$dir2/Con_E2_DRB_Input$end,newPol2_E2_DRB,,,40 \
	-i $dir2/KD_RNAPII$end,$dir2/KD_Input$end,KDnewPol2_ctrl,,,40 \
        -i $dir2/KD_E2_RNAPII$end,$dir2/KD_E2_Input$end,KDnewPol2_E2,,,40 \
        -i $dir2/KD_DRB_RNAPII$end,$dir2/KD_DRB_Input$end,KDnewPol2_DRB,,,40 \
        -i $dir2/KD_E2_DRB_RNAPII$end,$dir2/KD_E2_DRB_Input$end,KDnewPol2_E2_DRB,,,40 \



