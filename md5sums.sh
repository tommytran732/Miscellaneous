#!/bin/bash

output(){
    echo -e '\e[36m'$1'\e[0m';
}

if [[ -f file_info_output.txt ]]; then
    output "Temporary files found! Did you already run the script?"
    output "Exiting"
    exit 1
fi

output "Enter the directory to search: "
read -r DIR

output "Searching for files"
find "${DIR}" -type f -exec md5sum {} \; > md5sums.txt

output "Done."
