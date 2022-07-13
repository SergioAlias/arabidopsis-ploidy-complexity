#!/bin/bash

# micro-script para ejecutar Trinity

# Variable declaration

 CARPETA='/scratch/salias/wdir'
 
 NCPU='30'   # number of CPUs to be used
 RAM='100G'  # reserved RAM memory, at least 4GBs per CPU
 SAMPLE='SRR545212'  # label
 echo 'transcriptome= '$SAMPLE


for i in {a,b,c};

do 
	# rm -r ./trinity_out_dir
	
	echo $i
	TRANSCRIPTOME=$SAMPLE$i  # label
  	LEFT_FILE=$SAMPLE$i'.1.fastq'  # left file of the paired couple of files
 	RIGHT_FILE=$SAMPLE$i'.2.fastq'  # right file
 

	# Open log file
	printf "=================================================\n" > "$TRANSCRIPTOME".log
 	echo -e "               $TRANSCRIPTOME" >> "$TRANSCRIPTOME".log
 	printf "=================================================\n" >> "$TRANSCRIPTOME".log
 

	# Info trinity
 	printf "Ejecutando Trinity con estos argumentos:" >> "$TRANSCRIPTOME".log
 	echo -e >> "$TRANSCRIPTOME".log
	echo "   input file 1 (left): " $LEFT_FILE >> "$TRANSCRIPTOME".log
	echo "   input file 2 (right): " $RIGHT_FILE >> "$TRANSCRIPTOME".log
	echo "   RAM: " $RAM >> "$TRANSCRIPTOME".log
	echo "   CPUs: " $NCPU >> "$TRANSCRIPTOME".log
	echo -e >> "$TRANSCRIPTOME".log

	# Info time
 	printf "Trinity start time: " >> "$TRANSCRIPTOME".log
 	echo -e >> "$TRANSCRIPTOME".log
 	date >> "$TRANSCRIPTOME".log
 	echo -e "" >> "$TRANSCRIPTOME".log



	# Ejecutable
 	Trinity --seqType fq --max_memory 100G  \
        	--left $LEFT_FILE \
        	--right $RIGHT_FILE \
       		--CPU 20  \
         	--min_kmer_cov 2  \
         	--normalize_reads
	# this options (--min_kmer_cov 2 and --normalize_reads) are used to normalization -dealing with very deep sequencing data

 	printf "Trinity finish time: " >> "$TRANSCRIPTOME".log
 	echo -e >> "$TRANSCRIPTOME".log
 	date >> "$TRANSCRIPTOME".log
 	echo -e "" >> "$TRANSCRIPTOME".log
 	echo -e "" >> "$TRANSCRIPTOME".log
 	echo -e "" >> "$TRANSCRIPTOME".log

 	printf "=========   Trinity statistics  ==================\n" >> "$TRANSCRIPTOME".log
 	echo -e "" >> "$TRANSCRIPTOME".log

	# statistics 
 	$TRINITY_HOME/util/TrinityStats.pl ./trinity_out_dir/Trinity.fasta >> "$TRANSCRIPTOME".log

 	# added by Sergio:

 	# rename and move Trinity.fasta file and log file
 	mv ./trinity_out_dir/Trinity.fasta ./trinity_out_dir/"$TRANSCRIPTOME"-Trinity.fasta
	mv ./trinity_out_dir/"$TRANSCRIPTOME"-Trinity.fasta /scratch/salias/trinity_assemblies
 	mv "$TRANSCRIPTOME".log /scratch/salias/trinity_assemblies

 	# remove trinity directory
 	rm -r ./trinity_out_dir

done

for j in SRR5819585

do

 TRANSCRIPTOME=$j  # label
 
 LEFT_FILE='sicked-cutadapted-'$TRANSCRIPTOME'_1.fastq'  # left file of the paired couple of files
 RIGHT_FILE='sicked-cutadapted-'$TRANSCRIPTOME'_2.fastq'  # right file
 
 NCPU='30'   # number of CPUs to be used
 RAM='100G'  # reserved RAM memory, at least 4GBs per CPU



# Open log file
 printf "=================================================\n" > "$TRANSCRIPTOME".log
 echo -e "               $TRANSCRIPTOME" >> "$TRANSCRIPTOME".log
 printf "=================================================\n" >> "$TRANSCRIPTOME".log
 

# Info trinity
 printf "Ejecutando Trinity con estos argumentos:" >> "$TRANSCRIPTOME".log
 echo -e >> "$TRANSCRIPTOME".log
 echo "   input file 1 (left): " $LEFT_FILE >> "$TRANSCRIPTOME".log
 echo "   input file 2 (right): " $RIGHT_FILE >> "$TRANSCRIPTOME".log
 echo "   RAM: " $RAM >> "$TRANSCRIPTOME".log
 echo "   CPUs: " $NCPU >> "$TRANSCRIPTOME".log
 echo -e >> "$TRANSCRIPTOME".log

# Info time
 printf "Trinity start time: " >> "$TRANSCRIPTOME".log
 echo -e >> "$TRANSCRIPTOME".log
 date >> "$TRANSCRIPTOME".log
 echo -e "" >> "$TRANSCRIPTOME".log



# Ejecutable
 Trinity --seqType fq --max_memory 100G  \
         --left $LEFT_FILE \
         --right $RIGHT_FILE \
         --CPU 20  \
         --min_kmer_cov 2  \
         --normalize_reads
# this options (--min_kmer_cov 2 and --normalize_reads) are used to normalization -dealing with very deep sequencing data

 printf "Trinity finish time: " >> "$TRANSCRIPTOME".log
 echo -e >> "$TRANSCRIPTOME".log
 date >> "$TRANSCRIPTOME".log
 echo -e "" >> "$TRANSCRIPTOME".log
 echo -e "" >> "$TRANSCRIPTOME".log
 echo -e "" >> "$TRANSCRIPTOME".log

 printf "=========   Trinity statistics  ==================\n" >> "$TRANSCRIPTOME".log
 echo -e "" >> "$TRANSCRIPTOME".log

# statistics 
 $TRINITY_HOME/util/TrinityStats.pl ./trinity_out_dir/Trinity.fasta >> "$TRANSCRIPTOME".log

# added by Sergio:

# rename and move Trinity.fasta file and log file
 mv ./trinity_out_dir/Trinity.fasta ./trinity_out_dir/"$TRANSCRIPTOME"-Trinity.fasta
 mv ./trinity_out_dir/"$TRANSCRIPTOME"-Trinity.fasta /scratch/salias/trinity_assemblies
 mv "$TRANSCRIPTOME".log /scratch/salias/trinity_assemblies

 # remove trinity directory
 rm -r ./trinity_out_dir

done

exit 0