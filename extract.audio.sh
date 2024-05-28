#!/bin/bash

if [ "$#" -ne 2 ]; then
    echo "Usage: $0 <input_video> <output_audio>"
    exit 1
fi

INPUT_VIDEO="$1"
OUTPUT_AUDIO="$2"

# Extract audio using ffmpeg
ffmpeg -i "$INPUT_VIDEO" -vn -acodec copy "$OUTPUT_AUDIO"
