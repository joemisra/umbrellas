#!/usr/bin/env bash

sudo apt update
sudo apt-get update
sudo apt-get install -y git bc g++ make i2c-tools libudev-dev libevdev-dev liblo-dev libavahi-compat-libdnssd-dev libasound2-dev libncurses5-dev
sudo apt install rpi-eeprom
sudo apt install php php-fpm
sudo apt install nginx

sudo adduser pi www-data
sudo adduser www-data audio

cd ~/umbrellas

sudo chmod 644 install/systemd/*
sudo cp install/systemd/* /etc/systemd/system

sudo systemctl enable ttymidi0.service 
sudo systemctl enable ttymidi1.service 
sudo systemctl enable ttymidi2.service 
sudo systemctl enable ttymidi3.service 
sudo systemctl enable ttymidi4.service 

sudo cp --remove-destination /home/pi/umbrellas/install/boot/config.txt  /boot/config.txt
sudo cp --remove-destination /home/pi/umbrellas/install/webserver/default  /etc/nginx/sites-available/default
cp -r /home/pi/umbrellas/install/html/umbrellas  /var/www/html/umbrellas
sudo chown -R www-data:www-data /var/www/html/umbrellas
sudo cp --remove-destination /home/pi/umbrellas/install/99-com.rules  /etc/udev/rules.d/99-com.rules 

git clone https://github.com/okyeron/ttymidi.git
cd ttymidi
make
sudo make install

git clone https://github.com/mzero/amidiminder.git
cd amidiminder
make
sudo dpkg -i build/amidiminder.deb
