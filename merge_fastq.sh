#!/bin/bash

output(){
    echo -e '\e[36m'$1'\e[0m';
}

output "Please enter the main directory:"
read -r MAINDIR

if [ -d "$MAINDIR"/RESULT ]; then
    output "The ${MAINDIR}/RESULT directory already exists. Please make a bacup of your files, remove it and run the script again."
    exit 1
fi

mkdir "$MAINDIR"/RESULT

for DIR in $(find "${MAINDIR}" -type d); do
    if [ "${DIR}" != "$MAINDIR"/RESULT ] && [ "${DIR}" != "$MAINDIR" ];then
        find "$DIR" -type f -name "*fastq.gz" > "$DIR"/filesInDir.txt
        if [ ! -s "$DIR"/filesInDir.txt ]; then
            noCULL=1
        else
            for gzippedFile in $(cat "$DIR"/filesInDir.txt); do
                gunzip -k ${gzippedFile}
            done
            noCULL=0
        fi
        cat "$DIR"/*.fastq > "$MAINDIR"/RESULT/$(basename "${DIR}").fastq
        gzip "$MAINDIR"/RESULT/$(basename "${DIR}").fastq
        if [ "${noCULL}" == "0" ]; then
            rm -f "$DIR"/*.fastq
        fi
    fi
done

output "Done"
