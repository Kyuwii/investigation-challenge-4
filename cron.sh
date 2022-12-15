#!/bin/bash

# Set the user to run the job as
USER=pierre

# Stop the Apache2 service every minute
* * * * * /usr/bin/runuser -l $USER -c "/usr/sbin/service apache2 stop"
