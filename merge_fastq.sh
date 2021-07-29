#!/bin/bash

echo "Please enter the main directory:"
read MAINDIR

echo "Please enter the extension to cat and merge (ex. .fastq, .fasta):"
read EXTENSION

if [ -f result"${EXTENSION}" ]; then
    echo "result""${EXTENSION}"" file already exist. Please make a back up of it and remove it from the current directory before running the script."
    exit 1
fi

find "$MAINDIR" -type f -name "*${EXTENSION}" -exec cat {} >> result"${EXTENSION}" \;

echo "All done. Have a good one."
