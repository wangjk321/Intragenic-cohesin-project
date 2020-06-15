dirDB=/home/wang/dbSaxo
end="-n2-m1-hg38-raw-mpbl-GR"
dir2=/work/WangData/Bando_new_DIC/parse2wigdir

drompa_draw MULTICI -p contVSE2_multiCI \
	-gt $dirDB/genome_table \
	-bed macsPeak/Con_RNAPII_peaks.narrowPeak\
	-i $dir2/Con_RNAPII$end,$dir2/Con_Input$end,newPol2_ctrl \
	-i $dir2/Con_E2_RNAPII$end,$dir2/Con_E2_Input$end,newPol2_E2



