#!/bin/bash

output(){
    echo -e '\e[36m'$1'\e[0m';
}

output "Please enter the main directory:"
read -r MAINDIR

output "Please type the name of the result file (excluding the .fasta part):"
read -r RESULT

if [ -f ${RESULT}.fasta ]; then
    output "The ${RESULT}.fasta file already exists. Please make a back up of it and remove it from the current directory before running the script."
    exit 1
fi

output "Merging files"
for file in $("$MAINDIR" -type f -name "*.fasta"); do
    echo ">$(basename "${file}" | awk -F . '{ print $1 }')" >> "${RESULT}".fasta
    sed '1d' "${file}" >> "${RESULT}".fasta
done

output "All done. Have a good one."