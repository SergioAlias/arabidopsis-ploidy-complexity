#!/bin/bash
# script to run cutadapt and sickle 

# move to the folder with the transcriptomes
# and create two arrays with the name of the _1 and _2 files
# the () are important to do not create a list but an array


# hay que cambiar el directorio de trabajo !!!

cd /scratch/salias/wdir
   




if [ -f ./Procesados ];
then
echo "Ok, Procesados directory exists"
else
mkdir Procesados
fi


file_1=(`ls *_1.fastq`)
file_2=(`ls *_2.fastq`)


FILES=${#file_1[*]}

echo "number of files: " $FILES


echo "comienza bucle cutadapt"

for  (( i=0; i<$FILES; i++)) 
do
	echo $i 	
	echo ${file_1[i]}
	echo ${file_2[i]}	
	
	cutadapt -b AGATCGGAAGAGCACACGTCTGAACTCCAGTCAC -B AGATCGGAAGAGCGTCGTGTAGGGAAAGAGTGT -n 28  -o './cutadapted'-${file_1[i]} -p './cutadapted'-${file_2[i]}  ${file_1[i]} ${file_2[i]}
	echo
	sickle pe -f './cutadapted'-${file_1[i]} -r './cutadapted'-${file_2[i]} -t sanger -o 'sicked-cutadapted'-${file_1[i]} -p 'sicked-cutadapted'-${file_2[i]} -s 'singletons'-${file_1[i]}   >> output-sickle.txt
	rm './cutadapted'-${file_1[i]}
	rm './cutadapted'-${file_2[i]}
	mv sicked-cutadapted* ./Procesados/
	mv singletons* ./Procesados/
	# Remove initial files
	rm './'${file_1[i]}
	rm './'${file_2[i]}

done

exit 0
