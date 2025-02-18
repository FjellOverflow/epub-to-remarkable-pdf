#!/usr/bin/env bash

WEBUI_IP="10.11.99.1"
FILE="$1"

exit_with_warning () {
    echo -e "\033[0;31m$1\033[0m"
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

# check that reMarkable web-ui is reachable
ping -c 1 $WEBUI_IP > /dev/null 2>&1

if [ $? -ne 0 ]
then
    exit_with_warning "Couldn't reach reMarkable. Is the device plugged in and 'USB connection' enabled in 'Settings' -> 'Storage'?"
fi


# upload via ReST
curl -s -o /dev/null \
    "http://$WEBUI_IP/upload" \
    -H "Origin: http://$WEBUI_IP" \
    -H "Accept: */*" \
    -H "Referer: http://$WEBUI_IP/" \
    -H "Connection: keep-alive" \
    -F "file=@$FILE;filename=$(basename "$FILE");type=application/pdf"


if [ $? -eq 0 ]
then
    echo -e "\033[0;32mUpload successful\033[0m"
else
    exit_with_warning "Upload failed."
fi