#!/bin/bash


sudo curl http://git.kolibrios.org/api/packages/Egor00f/debian/repository.key -o /etc/apt/keyrings/gitea-Egor00f.asc
echo "deb [signed-by=/etc/apt/keyrings/gitea-Egor00f.asc] http://git.kolibrios.org/api/packages/Egor00f/debian bookworm main" | sudo tee -a /etc/apt/sources.list.d/gitea.list
sudo apt update
echo '/home/autobuild/tools' | sudo apt install kos32-gcc -y

