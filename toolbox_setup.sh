#!/bin/bash

#Script to setup a toolbox container with development tools

sudo dnf upgrade -y
sudo dnf autoremove -y
sudo dnf install neofetch butane net-tools java-latest-openjdk speedtest-cli -y

#Pentest tools
sudo dnf install nmap hydra wireshark sqlninja -y