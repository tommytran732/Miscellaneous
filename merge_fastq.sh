#!/bin/bash

output(){
    echo -e '\e[36m'$1'\e[0m';
}

output "Please enter the main directory:"
read -r MAINDIR

if [ -d "$MAINDIR"/RESULT ]; then
    output "The " "$MAINDIR" "/RESULT diretcory already exists. Please make a bacup of your files, remove it and run the script again."
    exit 1
fi

mkdir "$MAINDIR"/RESULT

for DIR in $(find "${MAINDIR}" -type d); do
    if [ "${DIR}" != "$MAINDIR"/RESULT ] && [ "${DIR}" != "$MAINDIR" ];then
        find "$DIR" -type f -name "*fastq.gz" -exec gunzip -k {} \;
        cat "$DIR"/*.fastq > "$MAINDIR"/RESULT/$(basename "${DIR}").fastq
        rm -f "$DIR"/*.fastq
    fi
done

output "Done"