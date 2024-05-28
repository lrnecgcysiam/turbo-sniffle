#!/bin/bash

if [ "$#" -ne 5 ]; then
    echo "Usage: $0 <URL> <output_path> <start_time> <end_time> <output_trimmed_path>"
    exit 1
fi

URL="$1"
OUTPUT_PATH="$2"
START_TIME="$3"
END_TIME="$4"
OUTPUT_TRIMMED_PATH="$5"

# Download video
youtube-dl -o "$OUTPUT_PATH" "$URL"

# Convert start and end times to seconds
start_seconds=$(date -d "1970-01-01 $START_TIME UTC" +%s)
end_seconds=$(date -d "1970-01-01 $END_TIME UTC" +%s)

# Trim video
ffmpeg -ss "$start_seconds" -i "$OUTPUT_PATH" -to "$end_seconds" -c copy "$OUTPUT_TRIMMED_PATH"
