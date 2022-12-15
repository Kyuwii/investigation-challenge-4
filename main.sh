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
   	ufw allow 'Apache'
   	systemctl enable apache2
   	systemctl restart apache2

   	apt update && apt install -y zip

   	# create file & directory for john
   	mkdir -p /home/john/Documents 2> /dev/null
   	mkdir -p /home/john/Telechargements 2> /dev/null
   	mkdir -p /home/john/Images 2> /dev/null
   	mkdir -p /home/john/Musique 2> /dev/null
   	mkdir -p /home/john/Public 2> /dev/null
   	mkdir -p /ftp 2> /dev/null
   	mkdir -p /ftp/home 2> /dev/null
   	mkdir -p /ftp/home/keys 2> /dev/null
   	mkdir -p /ftp/home/share 2> /dev/null

   	chmod 757 /home/john/Documents
   	chmod 757 /home/john/Telechargements
   	chmod 757 /home/john/Images
   	chmod 757 /home/john/Musique
   	chmod 757 /home/john/Public

   	chmod 757 /ftp
   	chmod 757 /ftp/home
   	chmod 757 /ftp/home/keys
   	chmod 757 /ftp/home/share

   	for i in {0..34}; do
   		touch /ftp/home/share/facture2022_$i.txt;
   		dd if=/dev/urandom of=/ftp/home/share/facture2022_$i.txt bs=2k count=2;
   	done

   	for i in {0..3}; do
   		touch /home/john/Documents/AO_$i.txt;
   		dd if=/dev/urandom of=/home/john/Documents/AO_$i.txt bs=1k count=3;
   	done

   	for i in {0..5}; do
   		touch /home/john/Documents/ressource_$i.jpg;
   		dd if=/dev/urandom of=/home/john/Documents/ressource_$i.jpg bs=1k count=2;
   	done

   	touch /home/john/Documents/backgroung.png;
   	dd if=/dev/urandom of=/home/john/Documents/backgroung.png bs=1k count=1
   	

   	# configure FTP logs

   	# add encrypted file in FTP
   	touch /ftp/home/keys/secret_key.pem
   	chmod 757 /ftp/home/keys/secret_key.pem
   	echo "LS0tLS0tLS0tLS0tRU5DUllQVElPTl9LRVktLS0tLS0tLS0tLS0KVGhlIGNha2UgaXMgYSBsaWU=" > /ftp/home/keys/secret_key.pem

   	# generate FTP traffic and logs

   	# generate user history
   	runuser -l john -c 'pwd'
   	runuser -l john -c 'ls -alt'
   	runuser -l john -c 'mkdir /home/john/Documents/.spy'
   	runuser -l john -c 'touch /home/john/Documents/.spy/.spy.sh'


   	runuser -l john -c 'touch ~/.bash_history'

   	cp bash_history /home/john/.bash_history

 


}

main