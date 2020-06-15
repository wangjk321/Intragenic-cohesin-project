dirDB=/home/wang/dbSaxo
end="-n2-m1-hg38-raw-mpbl-GR"
dir1=/work/CohesinProject/MCF7/ChIP-seq/hg38/parse2wigdir
dir2=/work/WangData/Bando_new_DIC/parse2wigdir

drompa_draw PC_SHARP -p newPol2 -gene $dirDB/refFlat.dupremoved.txt \
        -gt $dirDB/genometable_all.txt -lpp 2 -ls 400 -scale_tag 15\
        -r region.txt -nosig -bn 1 -viz 0 -offbg \
	-i $dir2/Con_RNAPII$end,$dir2/Con_Input$end,RNAP2_Ctrl,,,50 \
        -i $dir2/Con_E2_RNAPII$end,$dir2/Con_E2_Input$end,RNAP2_E2,,,50 \
	-i $dir2/Con_DRB_RNAPII$end,$dir2/Con_DRB_Input$end,RNAP2_DRB,,,50 \
	-i $dir2/Con_E2_DRB_RNAPII$end,$dir2/Con_E2_DRB_Input$end,RNAP2_E2+DRB,,,50 \
	-i $dir2/KD_RNAPII$end,$dir2/KD_Input$end,RNAP2_Ctrl_KD,,,50 \
        -i $dir2/KD_E2_RNAPII$end,$dir2/KD_E2_Input$end,RNAP2_E2_KD,,,50 \
        -i $dir2/KD_DRB_RNAPII$end,$dir2/KD_DRB_Input$end,RNAP2_DRB_KD,,,50 \
        -i $dir2/KD_E2_DRB_RNAPII$end,$dir2/KD_E2_DRB_Input$end,RNAP2_E2+DRB_KD,,,50 \



