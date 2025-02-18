#!/usr/bin/env bash

FILE="$1"

exit_with_warning () {
    echo -e "${RED}$1${NONE}"
    exit 1
}

# check that filepath given and file exists
if [ -z "$FILE" ]
then
    exit_with_warning "No filepath supplied."
fi

if ! [ -e "$FILE" ]
then
    exit_with_warning "File $FILE does not exist."
fi

# calculate volume mappings for in- and output
HOST_IN=$(realpath $1)
CONTAINER_IN=/converter/$(basename "$1")
CONTAINER_OUT=/converter/$(basename "${1}" ".${1##*.}").pdf
HOST_OUT=$(dirname $1)/$(basename "${1}" ".${1##*.}").pdf

# create dummy output file so docker wont map volume as a new directory
if ! [ -e "$HOST_OUT" ]
then
    touch $HOST_OUT
fi

# run conversion command inside temporary container
docker run --rm -v "$HOST_IN":"$CONTAINER_IN" -v "$HOST_OUT":"$CONTAINER_OUT" ghcr.io/fjelloverflow/epub-to-remarkable-pdf:latest "$CONTAINER_IN"