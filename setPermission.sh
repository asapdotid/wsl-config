#!/bin/bash
# Purpose: Set correct permission files and dir permissions (Web root & Laravel) dynamically
# Author: Asapdotid < asapdotid@gmail.com >
# This script is released under GPL version 2.0 or above
# Set root permission as follows for the Nginx DocumentRoot
# + Dirs/Subdirs: corect permission to 0755
# + Files: corect permission to 0644
# + Laravel Storage: corect permission
# + Laravel Bootstrap Cache: corect permission
# Tested on Ubuntu linux 18.04 LTS & Ubuntu linux 18.04 LTS (WSL Windows 10)
# -------------------------------------------------------------------------------------------------
_fperm="0644"
_dperm="0755"
_laraperm="ug+rwx"
_ugperm="$USER:www-data"
_chmod="chmod"
_chown="chown"
_find="find"
_xargs="xargs"

read -p "Path directory do you want to set permission (ex: /var/www/html) ? " _dir
echo "I will change the file permission for dir and files to normalize mode for \"$_dir\""
read -p "Your current dir is $dir. Are you sure (y / n) ? " _ans

if [ "$_ans" == "y" ]
then
    for entry in "$_dir"/*
    do
        if [ -d "${entry}" ]; then
            echo "Changing onwership to $_ugperm for $entry..."
	        $_chown -R "${_ugperm}" "$entry"
            echo "Setting $_dperm permission all directory in path $entry directory...."
            $_find "$entry" -type d -print0 | $_xargs -0 -I {} $_chmod $_dperm {}
            echo "Setting $_fperm permission all files in path$entry directory...."
	        $_find "$entry" -type f -print0 | $_xargs -0 -I {} $_chmod $_fperm {}
            if [[ -d "${entry}/storage" && -d "${entry}/bootstrap/cache" ]]; then
                echo "laravel set permission for storage and bootstrap/cache directory"
                $_chmod -R "${_laraperm}" "$entry/storage" "$entry/bootstrap/cache"
            fi
        fi
    done
    echo "done..."
fi
