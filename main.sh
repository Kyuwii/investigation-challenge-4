#!/bin/bash

set -e 


main()
{
	# set users
	johnPass="dvH01"
	mikePass="typR4"
	pierrePass="vGbR1"

   	useradd john -m -s /bin/bash 2>/dev/null
   	echo "john:$johnPass" | chpasswd

   	useradd mike -m -s /bin/bash 2>/dev/null
   	echo "mike:$mikePass" | chpasswd

   	useradd pierre -m -s /bin/bash 2>/dev/null
   	echo "pierre:$pierrePass" | chpasswd

   	apt update && apt install -y apache2
   	apt update && apt install -y gcc
   	ufw allow 'Apache'
   	systemctl enable apache2
   	systemctl restart apache2

   	apt update && apt install -y zip

   	# create file & directory for/pierre
   	mkdir -p /home/pierre/Documents 2> /dev/null
   	mkdir -p /home/pierre/Telechargements 2> /dev/null
   	mkdir -p /home/pierre/Images 2> /dev/null
   	mkdir -p /home/pierre/Musique 2> /dev/null
   	mkdir -p /home/pierre/Public 2> /dev/null
   	mkdir -p /ftp 2> /dev/null
   	mkdir -p /ftp/home 2> /dev/null
   	mkdir -p /ftp/home/keys 2> /dev/null
   	mkdir -p /ftp/home/share 2> /dev/null

   	chmod 757 /home/pierre/Documents
   	chmod 757 /home/pierre/Telechargements
   	chmod 757 /home/pierre/Images
   	chmod 757 /home/pierre/Musique
   	chmod 757 /home/pierre/Public

   	chmod 757 /ftp
   	chmod 757 /ftp/home
   	chmod 757 /ftp/home/keys
   	chmod 757 /ftp/home/share

   	cp capture.pcap /home/pierre/Telechargements/captureServeurFTP.pcap

   	for i in {0..34}; do
   		touch /ftp/home/share/facture2022_$i.txt;
   		dd if=/dev/urandom of=/ftp/home/share/facture2022_$i.txt bs=2k count=2;
   	done

   	for i in {0..3}; do
   		touch /home/pierre/Documents/AO_$i.txt;
   		dd if=/dev/urandom of=/home/pierre/Documents/AO_$i.txt bs=1k count=3;
   	done

   	for i in {0..5}; do
   		touch /home/pierre/Documents/ressource_$i.jpg;
   		dd if=/dev/urandom of=/home/pierre/Documents/ressource_$i.jpg bs=1k count=2;
   	done

   	touch /home/pierre/Documents/backgroung.png;
   	dd if=/dev/urandom of=/home/pierre/Documents/backgroung.png bs=1k count=1
   	

   	# create generic website
	cp index.html /var/www/html/index.html

	cp tout_a_fait_normal.c /home/pierre/Documents/tout_a_fait_normal.c
	runuser -l pierre -c 'cc /home/pierre/Documents/tout_a_fait_normal.c /home/pierre/Documents/tout_a_fait_normal.out'
	runuser -l pierre -c 'rm /home/pierre/Documents/tout_a_fait_normal.c'
	runuser -l pierre -c './home/pierre/Documents/tout_a_fait_normal.out'

   	# configure FTP logs

   	# add encrypted file in FTP
   	touch /ftp/home/keys/secret_key.pem
   	chmod 757 /ftp/home/keys/secret_key.pem
   	echo "LS0tLS0tLS0tLS0tRU5DUllQVElPTl9LRVktLS0tLS0tLS0tLS0KVGhlIGNha2UgaXMgYSBsaWU=" > /ftp/home/keys/secret_key.pem

   	# generate FTP traffic and logs

   	# generate user history
   	runuser -l pierre -c 'pwd'
   	runuser -l pierre -c 'ls -alt'
   	runuser -l pierre -c 'cd /home/pierre/'

   	runuser -l pierre -c 'touch ~/.bash_history'

   	cp bash_history /home/pierre/.bash_history

	chmod +x cron.sh
	crontab -u $USER cron.sh



}

main