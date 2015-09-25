#!/bin/bash
################################################
# A tour of the Archive.org Advanced Search API. 
# 
# Endpoint:
#   https://archive.org/advancedsearch.php
#
# For more details, refer to:
#   https://archive.org/advancedsearch.php#raw
################################################


############################################################################
# Use curl and jq to iterate through search results for the specified query.
# Usage:
#   curl_search "$query"
############################################################################ 
function curl_search() {
    QUERY="$@"
    ROWS=100

    # Calculate total pages of search results.
    NUM_FOUND=$(curl -s "https://archive.org/advancedsearch.php?q=${QUERY}&rows=${ROWS}&output=json" | bin/jq '.response.numFound')
    TOTAL_PAGES="$(($NUM_FOUND/$ROWS))"
    if [ $(expr $NUM_FOUND % $ROWS) != 0 ]; then
        TOTAL_PAGES=$(($TOTAL_PAGES+1))
    fi

    # Paginate through search results.
    i=1
    while [ $i -le $TOTAL_PAGES ]; do
        curl -s "https://archive.org/advancedsearch.php?q=${QUERY}&rows=${ROWS}&output=json&page=${i}" | bin/jq -c '.response.docs[]'
        i=$(($i+1))
    done
}

#curl_search 'collection:ote'


#################################################################
# Use the ia command-line tool to iterate through search results.
#################################################################
#bin/ia search 'collection:ote'


#################################################################################
# Create a list of items from search results returned by the Advanced Search API.
#################################################################################
#curl_search 'collection:ote' | jq -r '.identifier' > itemlist.txt
#bin/ia search 'collection:ote' --itemlist > itemlist.txt
