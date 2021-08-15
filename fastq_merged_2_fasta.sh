#!/bin/bash

output(){
    echo -e '\e[36m'$1'\e[0m';
}

output "Please enter the main directory:"
read -r MAINDIR

if [ -f fastq_merged_2_fasta.fasta ]; then
    output "fastq_merged_2_fasta.fasta file already exists. Please make a back up of it and remove it from the current directory before running the script."
    exit 1
fi

find "$MAINDIR" -type f -name "*.fastq" -exec sed -n '1~4s/^@/>/p;2~4p' {} \; >> fastq_merged_2_fasta.fasta

output "All done. Have a good one."
