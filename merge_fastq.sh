#!/bin/bash

echo "Please enter the main directory:"
read MAINDIR

echo "Please enter the extension to cat and merge (ex. .fastq, .fasta):"
read EXTENSION

find "$MAINDIR" -type f -name "*${EXTENSION}" -exec cat {} >> result"${EXTENSION}" \;

echo "All done. Have a good one."
