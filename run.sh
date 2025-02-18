#!/usr/bin/env bash

FILE="$1"

exit_with_warning () {
    echo -e "${RED}$1${NONE}"
    exit 1
}

if [ -z "$FILE" ]
then
    exit_with_warning "No filepath supplied."
fi

if ! [ -e "$FILE" ]
then
    exit_with_warning "File $FILE does not exist."
fi

FILENAME=$(basename "$1")

HOST_IN=$1
CONTAINER_IN=/converter/$FILENAME
CONTAINER_OUT=/converter/$(basename "${1}" ".${1##*.}").pdf
HOST_OUT=$(dirname $1)/$(basename "${1}" ".${1##*.}").pdf

if ! [ -e "$HOST_OUT" ]
then
    touch $HOST_OUT
fi

docker run --rm -v "$HOST_IN":"$CONTAINER_IN" -v "$HOST_OUT":"$CONTAINER_OUT" ghcr.io/fjelloverflow/epub-to-remarkable-pdf:latest "$CONTAINER_IN"