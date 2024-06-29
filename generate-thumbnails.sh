#!/bin/bash

#  this script generates a thumbnail for each .mp4 file in the current directory
# using the ffmpeg tool.

# Loop over all .mp4 files in the directory
for file in *.mp4; do
  # Use ffmpeg to create a thumbnail from the video
  # -i "$file" specifies the input file
  # -ss 00:00:01.000 seeks to 1 second into the video
  # -vframes 1 captures a single frame
  # "${file%.*}.png" specifies the output file name, replacing the .mp4 extension with .png
  ffmpeg -i "$file" -ss 00:00:10.000 -vframes 1 "${file%.*}.png"
done