#!/bin/bash

echo "Please enter the main directory:"
read MAINDIR

if [ -d "$MAINDIR"/RESULT ]; then
    echo "fastq_merged_2_fasta.fasta file already exists. Please make a back up of it and remove it from the current directory before running the script."
    exit 1
fi

mkdir "$MAINDIR"/RESULT

find "$MAINDIR" -type f -name "*.fastq" -exec sed -n '1~4s/^@/>/p;2~4p' {} \; | tee "$MAINDIR"/RESULT/$(basename {}).fast

echo "All done. Have a good one."
