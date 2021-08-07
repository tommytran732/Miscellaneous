#!/bin/bash

output(){
    echo -e '\e[36m'$1'\e[0m';
}

output "Please enter the main directory:"
read -r MAINDIR

mkdir "$MAINDIR"/RESULT

for DIR in $(find "${MAINDIR}" -type d); do
    if [ "${DIR}" != "$MAINDIR"/RESULT ] && [ "${DIR}" != "$MAINDIR" ];then
        find "$DIR" -type f -name "*fastq.gz" -exec gunzip -k {} \;
        cat "$DIR"/*.fastq > RESULT/$(basename "${DIR}").fastq
        rm -f "$DIR"/*.fastq >/dev/null
    fi
done

output "Done"