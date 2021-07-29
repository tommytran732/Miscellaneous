#!/bin/bash

echo "Please enter the main directory:"
read MAINDIR

find $MAINDIR -type f -name '*.fastq' -exec cat {} >> result.fastq \;

echo "All done. Have a good one."
