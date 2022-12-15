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

   	apt update && apt install -y vsftpd

   	cp /etc/vsftpd.conf /etc/vsftpd.conf.original

   	apt-get install ufw
   	ufw enable

   	ufw allow OpenSSH
   	ufw allow 20/tcp
	ufw allow 21/tcp
	ufw allow 990/tcp
	ufw allow 40000:50000/tcp
 
	echo 'user_sub_token=$USER local_root=/home/$USER/ftp' >> /etc/vsftpd.conf

   	apt update && apt install -y zip

   	# create file & directory for john
   	mkdir -p /home/john/ftp 2> /dev/null
  	

   	for i in {0..34}; do
   		touch /home/john/ftp/facture2022_$i.txt;
   		dd if=/dev/urandom of=/home/john/ftp/facture2022_$i.txt bs=2k count=2;
   	done

   	for i in {0..3}; do
   		touch /home/john/ftp/AO_$i.txt;
   		dd if=/dev/urandom of=/home/john/ftp/AO_$i.txt bs=1k count=3;
   	done

   	for i in {0..5}; do
   		touch /home/john/ftp/ressource_$i.jpg;
   		dd if=/dev/urandom of=/home/john/ftp/ressource_$i.jpg bs=1k count=2;
   	done

   	touch /home/john/ftp/backgroung.png;
   	dd if=/dev/urandom of=/home/john/ftp/backgroung.png bs=1k count=1
   	

   	


}

main