#!/bin/bash

echo "Please enter the main directory:"
read -r MAINDIR

if [ -d "$MAINDIR"/RESULT ]; then
    echo "RESULT folder already exists. Please make a back up of it and remove it from the current directory before running the script."
    exit 1
fi

echo "Enter bp to trim left side:"
read -r LEFT

echo "Enter bp to trim right side:"
read -r RIGHT

mkdir "$MAINDIR"/RESULT

for file in $(find "$MAINDIR" -type f -name "*.fastq.gz"); do
    seqtk trimfq -b "${LEFT}" -e "${RIGHT}" "${file}" > "$MAINDIR"/RESULT/$(basename "${file}" | awk -F . '{ print $1 }').fastq
done

for file in $(find "$MAINDIR" -type f -name "*.fastq"); do
    seqtk trimfq -b "${LEFT}" -e "${RIGHT}" "${file}" > "$MAINDIR"/RESULT/$(basename "${file}")
done

echo "All done. Have a good one."
(ive not 