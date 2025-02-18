#!/usr/bin/env bash

FONT="Georgia"
FILE="$1"

exit_with_warning () {
    echo -e "\033[0;31m$1\033[0m"
    exit 1
}

# check that filepath given, file exists and is epub
if [ -z "$FILE" ]
then
    exit_with_warning "No filepath supplied."
fi

if ! [ -e "$FILE" ]
then
    exit_with_warning "File $FILE does not exist."
fi

if ! [ "${FILE##*.}" = "epub" ]
then
    exit_with_warning "$FILE is not an .epub file."
fi

# check calibre and 'Georgia' font is installed on system
if ! fc-list | grep -i "$FONT" > /dev/null
then
    exit_with_warning "Font '$FONT' is not installed."
fi

if ! command -v "ebook-convert" >/dev/null 2>&1
then
    exit_with_warning "Calibre not installed."
fi

# calculate new filename and quietly run calibre conversion command
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

# report back result
if [ $? -eq 0 ]; then
    echo -e "\033[0;32mCreated $(basename $NEW_FILE)\033[0m"
else
    exit_with_warning "Conversion failed."
fi