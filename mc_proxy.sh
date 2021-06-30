#!/bin/sh

#Executing commands in the script's directory
cd "$(dirname "$0")"


# Automatically restart it if it crashes
while true
do

   #Automactically update FlameCord
   wget https://www.arkflame.com/FlameCord.jar
   if [ -f FlameCord.jar.1 ]; then
      rm -f FlameCord.jar
      mv FlameCord.jar.1 FlameCord.jar
   fi

   #Ensure the plugins directory is created
   mkdir plugins

   #Automatically update Geyser & Floodgate
   cd plugins
   wget https://ci.nukkitx.com/job/GeyserMC/job/Geyser/job/master/lastSuccessfulBuild/artifact/bootstrap/bungeecord/target/Geyser-BungeeCord.jar
   if [ -f Geyser-BungeeCord.jar.1 ]; then
      rm -f Geyser-BungeeCord.jar
      mv Geyser-BungeeCord.jar.1 Geyser-BungeeCord.jar
   fi

   wget https://ci.nukkitx.com/job/GeyserMC/job/Floodgate/job/development/lastSuccessfulBuild/artifact/bungee/target/floodgate-bungee.jar
   if [ -f floodgate-bungee.jar ]; then
      rm -f floodgate-bungee.jar
      mv floodgate-bungee.jar.1 floodgate-bungee.jar
   fi

   #Return to the original directory
   cd ..

   # Start the server
   java -Xms1G -Xmx8G -jar FlameCord.jar
   echo "Rebooting! Press CTRL-C to stop process"

done
