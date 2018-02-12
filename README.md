# Docker Setup for Gatsby & Strapi
This repo (will) Utilized Docker to create a fully integrated system for GatsbyJS and StrapiJS.

Author: Braden Witherwax (@radenB)

This repo is still under development and does not currently have Gatsby or Strapi installed and working. Still getting the container functioning properly on build before trying to integrate.

## Building Docker Image
To build the initial docker image, verify docker has been successfully installed. Jump to the installed directory and run the following command

```docker -t gatsby-strapi-image .```

If you change the name `gatsby-strapi-image` be sure to adjust your command when launching your container.

## Launching the Docker Container
After you've installed the new docker image you will need to run the following

```docker run --name NEWCONTAINER -p 8080:80 gatsby-strapi-image```

This will initialize the Docker Container and allow access at `http://localhost:8080`.

## Logging in to running Container
Once your container has been initialized you will now be able to log in by running the following

```docker exec -t -i NEWCONTAINER /bin/bash```
