#!/usr/bin/env bash
#===============================================================================
#
#          FILE:  freeze.sh
# 
#         USAGE:  sudo ./freeze.sh 
# 
#   DESCRIPTION:  Part of the Freeze/Thaw set of scripts.  This script creates a 
#                 tarball of the users home directory
# 
#       OPTIONS:  ---
#  REQUIREMENTS:  Root privileges.  You must be logged in as a 'root' user
#                 You cannot be logged in as the user to be 'frozen'
#          BUGS:  ---
#         NOTES:  Inspired by 
#                 http://www.linuxquestions.org/linux/answers/Applications_GUI_Multimedia/Deepfreeze_for_Linux
#        AUTHOR:  C Hawley 
#       COMPANY:  
#       VERSION:  1.0
#       CREATED:  02/24/2011 12:18:55 PM EST
#      REVISION: Mon 09 Oct 2017 05:15:49 PM EDT
#===============================================================================

set -o nounset                               # Treat unset variables as an error

# Check for empty argument
if [ -z "${1:-}" ]; then
	arg="undefined"
	echo "You must specify the username and archive location"
	exit 1
fi

frozenuser="${1}"
frozenarchive="${2}/${frozenuser}.frozen.tgz"

# If Previously frozen file exists - remove it.
if [ -f "${frozenarchive}" ]; then
	rm -f "${frozenarchive}"
fi

# create new frozen file
# tar options:
# -p extract all protection information
# -P don't strip leading '/'s from file names
tar -cpPf "${frozenarchive}" /home/"${frozenuser}"
