#!/bin/bash

# Ask for the directory name
echo "Enter the directory name:"
read directory_name

# Check if the directory exists
if [ ! -d "$directory_name" ]; then
    echo "Directory not found."
    exit 1
fi

# Move to the directory
cd "$directory_name"

# Delete WordPress files and directories without wp-content and wp-config.php
rm -rf cgi-bin wp-admin wp-includes index.php license.txt readme.html wp-activate.php wp-blog-header.php wp-comments-post.php wp-cron.php wp-links-opml.php wp-load.php wp-login.php wp-mail.php wp-settings.php wp-signup.php wp-trackback.php xmlrpc.php

# Download and extract the latest WordPress zip file
wget -q -O "wordpress.zip" "https://wordpress.org/latest.zip"
unzip -qo "wordpress.zip"
rm "wordpress.zip"

# Move all files and directories (except wp-content and wp-config-sample.php) to the previous directory
cd wordpress

# Create an array of files to exclude
exclude_files=(wp-content wp-config-sample.php)

# Loop through all files and directories
for item in *; do
    # Check if the item is not in the exclude list
    if [[ ! " ${exclude_files[@]} " =~ " ${item} " ]]; then
        mv "$item" ../
    fi
done

cd ..

# Remove the empty 'wordpress' directory
rm -rf wordpress

echo "Hello Sir! WordPress Core File Replaced Successfully."
