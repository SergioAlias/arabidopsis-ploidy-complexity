#!/bin/bash
# script to apply fastq-dump to the sra files in a folder
# Sergio Alías

CARPETA='/scratch/salias/wdir'

cd $CARPETA


files=(`ls *.sra`)
NumFILES=${#files[*]}


echo 'Running script-fastq-dump.sh ...'
echo "Number of files: " $NumFILES


for  (( i=0; i<$NumFILES; i++))
do
        SAMPLE=${files[i]}  # label
        echo '--------------------------------------'
	echo 'Current file: '$SAMPLE
        fastq-dump --split-files $SAMPLE
        rm $SAMPLE
  done

exit 0
