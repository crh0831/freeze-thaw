#!/usr/bin/env bash
#===============================================================================
#
#          FILE:  thaw.sh
# 
#         USAGE:  sudo ./thaw.sh 
# 
#   DESCRIPTION:  Part of the Freeze/Thaw set of scripts.  This script extracts a 
#                 tarball of the users home directory
# 
#       OPTIONS:  ---
#  REQUIREMENTS:  Must be run at boot:
#                 Save this script in the /etc/init.d/ directory.
#                 Make it executable (chmod 755 /ect/init.d/thaw.sh)					
#                 Then run 'update-rc.d thaw.sh defaults' (no quotes)
#          BUGS:  ---
#         NOTES:  Inspired by:
#                 http://www.linuxquestions.org/linux/answers/Applications_GUI_Multimedia/Deepfreeze_for_Linux
#                 Runlevel info:
#                 http://embraceubuntu.com/2005/09/07/adding-a-startup-script-to-be-run-at-bootup/		
#        AUTHOR:  C Hawley 
#       COMPANY:  
#       VERSION:  1.0
#       CREATED:  02/24/2011 12:18:55 PM EST
#      REVISION: Mon 09 Oct 2017 05:16:19 PM EDT
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

# remove existing user directory
rm -rf /home/"${frozenuser}"

# extract user tarball
# tar options:
# -p extract all protection information
# -P don't strip leading '/'s from file names
tar -xpPf "${frozenarchive}" -C /
