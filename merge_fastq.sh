#!/bin/bash

output(){
    echo -e '\e[36m'$1'\e[0m';
}

output "Please enter the main directory:"
read -r MAINDIR

for DIR in $(find "${MAINDIR}" -type d); do
    find "$DIR" -type f -name "*fastq.gz" -exec gunzip -k {} \;
    cat "$DIR/*.fasta" > $(basename "${DIR}").fasta
    chattr +i $(basename "${DIR}").fasta
    rm -f "$DIR"/*.fasta >/dev/null
    chattr -i "$DIR"/$(basename "${DIR}").fasta
done

output "Done"