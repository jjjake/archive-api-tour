#!/bin/bash
################################################################################
# A tour of downloading files from Archive.org via the archive web infrastrucre.
#
# Endpoint:
#   https://archive.org/download/$identifier/$filename
#
# For more details, refer to:
#   https://blog.archive.org/2012/04/26/downloading-in-bulk-using-wget/
################################################################################


# Set logged-in cookies for access-restricted downloads.
IA_CONFIG="$HOME/.config/internetarchive.yml"
LOGGED_IN_SIG="$(grep 'logged-in-sig' $IA_CONFIG | awk '{print $NF}')"
LOGGED_IN_USER="$(grep 'logged-in-user' $IA_CONFIG | awk '{print $NF}')"


########################################################
# Download items from the specified itemlist using wget.
# Usage:
#   wget_download itemlist.txt
########################################################
function wget_download() {
    itemlist="$1"
    mkdir -p downloads
    wget --recursive \
         --span-hosts \
         --no-clobber \
         --no-parent \
         --no-host-directories \
         --cut-dirs 1 \
         --execute robots=off \
         --level 1 \
         --directory-prefix downloads \
         --header "Cookie: logged-in-user=${LOGGED_IN_USER}; logged-in-sig=${LOGGED_IN_SIG};" \
         --input-file "$itemlist" \
         --base 'https://archive.org/download/'
}

#wget_download itemlist.txt


##########################################################################################
# Download items from the specified itemlist *in parallel* using the ia command-line tool.
##########################################################################################
mkdir -p downloads
parallel 'bin/ia download {} --destdir=downloads' < itemlist.txt
