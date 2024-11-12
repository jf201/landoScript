#!/bin/bash

# Initialize variables
URL=""
ADMIN_PASSWORD=""

# Parse command line arguments
while [[ "$#" -gt 0 ]]; do
    case $1 in
        --url) URL="$2"; shift ;;
        --admin_password) ADMIN_PASSWORD="$2"; shift ;;
        *) echo "Unknown parameter passed: $1"; exit 1 ;;
    esac
    shift
done

# Check if URL and ADMIN_PASSWORD are provided; if not, exit with error
if [ -z "$URL" ]; then
    echo "Error: --url parameter is required."
    exit 1
fi

if [ -z "$ADMIN_PASSWORD" ]; then
    echo "Error: --admin_password parameter is required."
    exit 1
fi

# Initialize a WordPress recipe using the latest WordPress version
lando init \
  --source remote \
  --remote-url https://wordpress.org/latest.tar.gz \
  --recipe wordpress \
  --webroot wordpress \
  --name "$URL"

# Start it up
lando start

# List information about this app
lando info

# Create a WordPress config file
lando wp config create \
  --dbname=wordpress \
  --dbuser=wordpress \
  --dbpass=wordpress \
  --dbhost=database \
  --path=wordpress

# Install WordPress
lando wp core install \
  --url="https://$URL.lndo.site/" \
  --title="My First Wordpress App" \
  --admin_user=admin \
  --admin_password="$ADMIN_PASSWORD" \
  --admin_email=dev@2null1.com \
  --path=wordpress

echo "Do not forget to set the php version to 8.3 in .lando.yml (and rebuild after)"
