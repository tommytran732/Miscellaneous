#!/bin/bash

echo "Please enter the main directory:"
read -r MAINDIR

if [ -d "$MAINDIR"/RESULT ]; then
    echo "fastq_merged_2_fasta.fasta file already exists. Please make a back up of it and remove it from the current directory before running the script."
    exit 1
fi

mkdir "$MAINDIR"/RESULT

for file in $(find "$MAINDIR" -type f -name "*.fastq.gz"); do
    sseqtk seq -a "${file}" > "$MAINDIR"/RESULT/$(basename "${file}" | awk -F . '{ print $1 }').fasta
done

echo "All done. Have a good one."
