#!/bin/bash

output(){
    echo -e '\e[36m'$1'\e[0m';
}

output "Please enter the main directory:"
read -r MAINDIR

output "Please type the name of the result file (excluding the .fasta part):"
read -r RESULT

if [ -f files2scan.txt ] || [ -f ${RESULT}.fasta ]; then
    output "The ${RESULT}.fasta or file2scan.txt file already exists. Please make a back up of it and remove it from the current directory before running the script."
    exit 1
fi

output "Searching for files"
find "$MAINDIR" -type f -name "*.fasta" > files2scan.txt

output "Merging files"
for file in $(cat files2scan.txt); do
    echo ">$(basename "${file}" | awk -F . '{ print $1 }')" >> ${RESULT}.fasta
    sed '1d' "${file}" >> ${RESULT}.fasta
done

output "Cleaning up"
rm files2scan.txt

output "All done. Have a good one."