 	# create cron job for stopping apache service
 	runuser -l pierre -c 'crontab -l > apacheCron'
	runuser -l pierre -c 'echo "10 * * * * systemctl stop apache2" >> apacheCron'
	runuser -l pierre -c 'crontab apacheCron'
	runuser -l pierre -c 'rm apacheCron'