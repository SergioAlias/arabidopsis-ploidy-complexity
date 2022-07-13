#!/bin/bash


# script to extract basic information from trinity log files located 
# in a folder
# Info for
#   1. Total trinity 'genes'
#   2. Total trinity transcripts
#   3. Median contig length
#   4. Median contig length (based on ONLY longest isoforms)
#   5. Average contig length
#   6. Average contig length (based on ONLY longest isoforms)



# VARIABLE DECLARATION
CARPETA='/scratch/salias/trinity_assemblies'
SALIDA='salida-de-prueba.txt'

cd $CARPETA
for file in *.log; do
	echo $file >> $SALIDA
	gawk '/genes/ {print $4}' $file >> $SALIDA
	gawk '/trinity transcripts/ {print $4}' $file >> $SALIDA
	gawk '/Median contig/ {print $4}' $file >> $SALIDA
	gawk '/Average contig/ {print $3}' $file >> $SALIDA
	# gawk '/Total assembled/ {print $4}' $file >> $SALIDA
	echo >>$SALIDA
	
	done
exit 0
	