#!/bin/bash

# Start Nginx
service nginx start

# Start MongoDB
service mongodb start

# Added to keep docker running
tail -f /var/log/server.log
