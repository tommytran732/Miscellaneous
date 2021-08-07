#!/bin/bash

output(){
    echo -e '\e[36m'$1'\e[0m';
}

output "Please enter the main directory:"
read -r MAINDIR

mkdir RESULT

for DIR in $(find "${MAINDIR}" -type d); do
    find "$DIR" -type f -name "*fasta.gz" -exec gunzip -k {} \;
    cat "$DIR/*.fasta" > RESULT/$(basename "${DIR}").fasta
    rm -f "$DIR"/*.fasta >/dev/null
done

output "Done"