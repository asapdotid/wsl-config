#!/bin/bash
# Purpose: Set correct webserver files and dir permissions
# Author: Vivek Gite < vivek@nixcraft.com >
# This script is released under GPL version 2.0 or above
# Set root permission as follows for the Apache / Lighttpd / Nginx DocumentRoot
# + Dirs/Subdirs: read-only and execute to others
# + Files: read-only permission
# Tested on Debian Linux v3/4/5/6 and RHEL v2/3/4/5/6
# -------------------------------------------------------------------------------------------------
_dir="${1:-.}"
_fperm="0644"
_dperm="0755"
_ugperm="asap:asap"
_chmod="/bin/chmod"
_chown="/bin/chown"
_find="/usr/bin/find"
_xargs="/usr/bin/xargs"
 
echo "I will change the file permission for dir and files to normalize mode for \"$_dir\""
read -p "Your current dir is ${PWD}. Are you sure (y / n) ?" ans
if [ "$ans" == "y" ]
then
	echo "Changing file onwership to $_ugperm for $_dir..."
	$_chown -R "${_ugperm}" "$_dir"
 
	echo "Setting $_fperm permission for $_dir directory...."
	$_chmod -R "${_fperm}" "$_dir"
 
	echo "Setting $_dperm permission for $_dir directory...."
	$_find "$_dir" -type d -print0 | $_xargs -0 -I {} $_chmod $_dperm {}
fi
