# Set the base image
FROM ubuntu

#Dockerfile author / maintainer
MAINTAINER Braden Witherwax <ldd.17.developer@gmail.com>

# Create new user and add to sudo group
RUN apt-get update
RUN apt-get install sudo
RUN adduser --disabled-password --gecos '' radenb
RUN adduser radenb sudo

# Install NodeJS
RUN apt-get update
RUN apt-get -y install nodejs

# Install NPM
RUN apt-get install -y npm

# Install vim / nano
RUN apt-get -y install vim nano

# Install nginx & Remove default file under sites-available
# This will allow for our root location to be used within NGINX
RUN apt-get -y install nginx
RUN cp /etc/nginx/sites-available/default /etc/nginx/sites-available/default.bk.txt
RUN rm -rf /etc/nginx/sites-available/default

# Create NGINX logs && Input new Conf file
RUN mkdir /etc/nginx/logs && touch /etc/nginx/logs/static.log

ADD ./nginx.conf /etc/nginx/conf.d/default.conf
ADD /src /www/html

# Install PM2 Package manager
RUN npm install -g pm2

# Install MongoDB
RUN apt-key adv --keyserver hkp://keyserver.ubuntu.com:80 --recv 2930ADAE8CAF5059EE73BB4B58712A2291FA4AD5 && \
    echo "deb [ arch=amd64,arm64 ] https://repo.mongodb.org/apt/ubuntu xenial/mongodb-org/3.6 multiverse" | sudo tee /etc/apt/sources.list.d/mongodb-org-3.6.list && \
    apt-get install -y mongodb

# Expose default port(S)
EXPOSE 80
EXPOSE 27017
EXPOSE 28017

# Add init file to container & make executable
# Then start Init Shell Script to initialize services
ADD ./init.sh /usr/local/bin/init.sh
RUN ["chmod", "+x", "/usr/local/bin/init.sh"]
# ENTRYPOINT ["/usr/local/bin/init.sh"]
CMD ["nginx", "-g", "daemon off"]
