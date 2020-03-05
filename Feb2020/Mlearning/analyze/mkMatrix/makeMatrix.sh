#continuous data 14
cut -f 1 ~/DIC/Feb2020/Mlearning/continuetxt/CTCF_signal.txt > cohesin.pos

for i in ~/DIC/Feb2020/Mlearning/continuetxt/*txt
do
	echo ${i##*/}
	cut -f 2 $i > ${i##*/}
done

paste cohesin.pos *txt > continue.merge

rm *txt 
rm cohesin.pos

#bino data 161
cut -f 1 ~/DIC/Feb2020/Mlearning/binotxt/ER.txt > cohesin.pos

for i in ~/DIC/Feb2020/Mlearning/binotxt/*txt
do
        echo ${i##*/}
        cut -f 2 $i > ${i##*/}
done

for a in `ls *txt |grep "ENC"`
do
	mv $a $a.encode
done
	
paste cohesin.pos *txt *encode > bino.merge

rm *txt *encode
rm cohesin.pos

cut -f 2-15 continue.merge > continue.temp
paste bino.merge continue.temp > All161b14c.matrix

rm continue.temp


