#!/bin/bash

output(){
    echo -e '\e[36m'$1'\e[0m';
}

if [[ -f file_info_temp1.txt || -f file_info_temp2.txt || -f file_info_output.txt ]]; then
    output "Temporary files found! Did you already run the script?"
    output "Exiting"
    exit 1
fi

output "Enter the directory to search: "
read -r DIR

output "Searching for files"
find "${DIR}" -type f -exec basename {} \; > file_info_temp1.txt
find "${DIR}" -type f -exec md5sum {} \; > file_info_temp2.txt

paste -d, file_info_temp1.txt file_info_temp2.txt | sort -n > file_info_output.txt
output "Cleaning up"

rm file_info_temp{1,2}.txt

output "Done."
