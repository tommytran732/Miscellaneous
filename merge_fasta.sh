#!/bin/bash

output(){
    echo -e '\e[36m'$1'\e[0m';
}

output "Please enter the main directory:"
read MAINDIR

if [ -f result.fasta ]; then
    output "result.fasta file already exist. Please make a back up of it and remove it from the current directory before running the script."
    exit 1
fi

find "$MAINDIR" -type f -name "*.fasta" > files2scan.txt

for file in `cat files2scan.txt`; do
    echo ">$(basename ${file})" > result.fasta
    sed '1d' ${file} > result.fasta
done

output "Cleaning up"
rm files2scan.txt

output "All done. Have a good one."