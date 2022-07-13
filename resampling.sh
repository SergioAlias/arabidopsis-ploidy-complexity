#!/bin/bash

# micro-script para hacer un remuestreo de los transcriptomas

# Variable declaration


CARPETA='/scratch/salias/wdir/'




for j in SRR545214
do

   SAMPLE=$j  # label
   LEFT_FILE='sicked-cutadapted-'$SAMPLE'_1.fastq'
   RIGHT_FILE='sicked-cutadapted-'$SAMPLE'_2.fastq'
   NSEQS='30000000'
 

   for i in {a,b,c};

	do
   echo "Resampling: "$SAMPLE$i " ----> "$NSEQS" sequences..."
	NR=$RANDOM	 
	fastq-sample -r -s $NR -n $NSEQS -o $SAMPLE$i $CARPETA$LEFT_FILE $CARPETA$RIGHT_FILE
	done
   done
exit 0


