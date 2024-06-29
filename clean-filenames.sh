#!/bin/bash

# Function to clean and rename files
clean_file_names() {
    for file in *; do
        if [ -f "$file" ]; then
            cleaned_name=$(echo "$file" | sed -e 's/[[:space:]]/-/g' -e 's/[^a-zA-Z0-9.-]//g')
            if [ "$cleaned_name" != "$file" ]; then
                mv "$file" "$cleaned_name"
            fi
        fi
    done
}

# Function to generate thumbnails
generate_thumbnails() {
    for file in *.mp4; do
        ffmpeg -i "$file" -ss 00:00:01.000 -vframes 1 "${file%.*}.png"
    done
}

# Clean file names and generate thumbnails
clean_file_names
generate_thumbnails