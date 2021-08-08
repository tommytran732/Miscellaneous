#!/bin/bash

output(){
    echo -e '\e[36m'$1'\e[0m';
}

output "Please enter the main directory:"
read -r MAINDIR

output "Doing the conversion..."

for file in $(find "$MAINDIR" -type f -name "*.fastq") do
    sed -n '1~4s/^@/>/p;2~4p' "${file}" > "$MAINDIR"/$(basename "${file}" | awk -F . { print '$1' }).fasta
done

for file in $(find "$MAINDIR" -type f -name "*.fastq.gz") do
    gunzip -k "${file}"
    sed -n '1~4s/^@/>/p;2~4p' "$MAINDIR"/$(basename "${file}" | awk -F '{ print $1 }').fastq > "$MAINDIR"/$(basename "${file}" | awk -F . '{ print $1 }').fasta
    rm "$MAINDIR"/$(basename "${file}" | awk -F '{ print $1 }').fastq
done

output "Done"