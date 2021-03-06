#!/bin/bash

output(){
    echo -e '\e[36m'$1'\e[0m';
}

output "Please enter the main directory:"
read -r MAINDIR

if [ -d "$MAINDIR"/RESULT ]; then
    output "RESULT folder already exists. Please make a back up of it and remove it from the current directory before running the script."
    exit 1
fi

mkdir "$MAINDIR"/RESULT

output "Enter the number of reads in subsample"
read -r SIZE

output "Running..."
for file in $(find "$MAINDIR" -type f -name "*.fastq"); do
    seqtk sample -s100 "${file}" "${SIZE}" > "$MAINDIR"/RESULT/$(basename "${file}").fastq
done

output "Done"