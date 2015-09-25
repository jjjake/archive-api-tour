#!/bin/bash
#####################################################################################
# Downloading item images from Archive.org via a 180px-wide standard image permalink.
#
# Endpoint:
#   https://archive.org/services/img/$identifier
#####################################################################################

IDENTIFIER="$1"
curl -sL "https://archive.org/services/img/${IDENTIFIER}" > $IDENTIFIER.jpg
