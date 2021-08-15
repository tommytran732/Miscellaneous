#!/bin/bash

output(){
    echo -e '\e[36m'$1'\e[0m';
}

top_bottom_options() {
    output "Do you want to take the top or bottom sequences?"
    read -r choice
    case $choice in
        1 ) TOP_BOTTOM="head"
            output "You have selected top sequences."
            output ""
            ;;
        2 ) TOP_BOTTOM="tail"
            output "You have selected bottom sequences."
            output ""
            ;;
        * ) output "You did not enter a valid selection."
            top_bottom_options
    esac
}

output "Please enter the main directory:"
read -r MAINDIR

if [ -d "$MAINDIR"/RESULT ]; then
    output "RESULT folder already exists. Please make a back up of it and remove it from the current directory before running the script."
    exit 1
fi

mkdir "$MAINDIR"/RESULT

output "Enter the number of reads in subsample"
read -r SIZE

COMPSIZE=$(( SIZE*4 ))

output "Running..."
for file in $(find "$MAINDIR" -type f -name "*.fastq"); do
    "${TOP_BOTTOM}" -n "${COMPSIZE}" "${file}" > "$MAINDIR"/RESULT/$(basename "${file}")
done

output "Done"