#!/bin/bash

output(){
    echo -e '\e[36m'$1'\e[0m';
}

if [[ -f file_info_temp1.txt || -f file_info_temp2.txt || -f file_info_temp3.txt || -f file_info_temp4.txt || -f file_info_output.txt ]]; then
    output "Temporary files found! Did you already run the script?"
    output "Exiting"
    exit 1
fi

output "Enter the directory to search: "
read -r DIR

output "Searching for files"
find "${DIR}" -type f -exec basename {} \; > file_info_temp1.txt
awk -F _ '{ print $1 }' file_info_temp1.txt > file_info_temp2.txt
find "${DIR}" -type f > file_info_temp3.txt

while read -r line; do
    if [[ $line == *"R1"* ]]; then
        echo "forward" >> file_info_temp4.txt
    elif [[ $line == *"R2"* ]]; then
        echo "reverse" >> file_info_temp4.txt
    else
        echo "none" >> file_info_temp4.txt
    fi
done < file_info_temp1.txt

paste -d, file_info_temp2.txt file_info_temp3.txt file_info_temp4.txt | sort -n > file_info_output.txt
output "Cleaning up"

rm file_info_temp{1,2,3,4}.txt

output "Done."
