#!/bin/bash
# script to obtain the number of sequences in the fastq files in a folder

CARPETA='/scratch/fperfect/MOREgen/HOJA-MORE-01/fastq-files/Procesados'

cd $CARPETA

files=(`ls *.fastq`)
NumFILES=${#files[*]}


echo "number of files: " $NumFILES


for  (( i=0; i<$NumFILES; i++))
do
        SAMPLE=${files[i]}  # label
        echo 'file= '$SAMPLE
        kseq_fp *$SAMPLE >> output-NumberSEQs.txt
  done

exit 0
