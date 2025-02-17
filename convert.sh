#!/usr/bin/env bash

FONT="Georgia"

FILE="$1"
RED='\033[0;31m'
GREEN='\033[0;32m' 
NONE='\033[0m'

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

if ! file --mime-type -b "$FILE" | grep -q 'application/epub+zip$'
then
  exit_with_warning "$FILE is not an .epub file."
fi

if ! fc-list | grep -i "$FONT" > /dev/null
then
    exit_with_warning "Font '$FONT' is not installed."
fi

if ! command -v "ebook-convert" >/dev/null 2>&1
then
    exit_with_warning "Calibre not installed."
fi

NEW_FILE=$(dirname "$FILE")/$(basename "$FILE" .epub).pdf

ebook-convert "$FILE" "$NEW_FILE" \
    --output-profile generic_eink_hd \
    --preserve-cover-aspect-ratio \
    --minimum-line-height 133 \
    --custom-size 1404x1872 -u devicepixel \
    --pdf-default-font-size 20 \
    --pdf-page-margin-left 80 \
    --pdf-page-margin-right 80 \
    --pdf-page-margin-top 65 \
    --pdf-page-margin-bottom 75 \
    --pdf-serif-family $FONT \
    &> /dev/null

if [ $? -eq 0 ]; then
    echo -e "${GREEN}$1${NONE}" "Created $NEW_FILE"
    FILE=$NEW_FILE
else
    exit_with_warning "Conversion failed."
fi