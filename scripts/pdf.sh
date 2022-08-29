#!/usr/bin/env bash
# Shell script for opening a pdf and moving it to a specific i3 window.

# Get the folder continaing the pdfs.
folder=/h/reading

# Select one at random. Only search one level deep.
pdf=$(find $folder -maxdepth 1 -type f -name "*.pdf" | shuf -n1)
echo "$pdf" > /tmp/debug_popup_pdf

# # Open the pdf in the selected window.
i3-msg "workspace 4; exec zathura \"$pdf\""
