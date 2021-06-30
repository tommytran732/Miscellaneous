#!/bin/bash

#Upgrade the system
sudo dnf upgrade -y

#Install python 3.9
sudo dnf module install python39/common -y

#Download File
wget https://repo.anaconda.com/miniconda/Miniconda3-py39_4.9.2-Linux-x86_64.sh

#Verify sha256 hash
echo 536817d1b14cb1ada88900f5be51ce0a5e042bae178b5550e62f61e223deae7c Miniconda3-py39_4.9.2-Linux-x86_64.sh | sha256sum -c

#Run the script
chmod u+x ./Miniconda3-py39_4.9.2-Linux-x86_64.sh
./Miniconda3-py39_4.9.2-Linux-x86_64.sh
rm Miniconda3-py39_4.9.2-Linux-x86_64.sh

#Update conda 
source ~/.bashrc
conda update conda -y

#Install Qiime
wget https://data.qiime2.org/distro/core/qiime2-2021.4-py38-linux-conda.yml
conda env create -n qiime2-2021.4 --file qiime2-2021.4-py38-linux-conda.yml
rm qiime2-2021.4-py38-linux-conda.yml

#Activate Qiime environment
source ~/.bashrc
conda activate qiime2-2021.4
