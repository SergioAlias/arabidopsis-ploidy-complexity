#!/bin/bash
# script to apply fastQC to the fastq files in a folder
# Sergio ALías

CARPETA='/scratch/salias/fastq/paired/2X/a_thaliana_col0/sustitutos/Procesados'

cd $CARPETA

if [ -f ./calidad_fastQC ];
then
echo "calidad_fastQC directory already exists"
else
mkdir calidad_fastQC
fi

files_1=(`ls sicked-cutadapted-*_1.fastq`)
files_2=(`ls sicked-cutadapted-*_2.fastq`)
NumFILES=${#files_1[*]}


echo 'Running script-fastQC.sh ...'
echo "Number of pair of files: " $NumFILES


for  (( i=0; i<$NumFILES; i++))
do
        SAMPLE_1=${files_1[i]}  # label 1
        SAMPLE_2=${files_2[i]}  # label 2
        echo '--------------------------------------'
	echo 'Current pair of files:'
        echo 'file_1 = '$SAMPLE_1
        echo 'file_2 = '$SAMPLE_2
        fastQC-opt --outdir ./calidad_fastQC --threads 2 $SAMPLE_1 $SAMPLE_2
  done

exit 0
