#!/bin/bash

# Ensure yt-dlp is installed
if ! command -v yt-dlp &> /dev/null; then
    echo "yt-dlp could not be found. Please install it first."
    exit 1
fi

# Check if the correct number of arguments are provided
if [ "$#" -ne 2 ]; then
    echo "Usage: $0 <YouTube Channel URL> <Log Directory>"
    exit 1
fi

# Define the YouTube channel URL and log file path
CHANNEL_URL="$1"
LOG_DIR="$2"

# Ensure the log directory exists
mkdir -p "$LOG_DIR"

# Define the log file path
LOG_FILE="${LOG_DIR}/download_video.log"

# Function to sanitize filenames
sanitize_filename() {
    echo "$1" | tr -cd '[:alnum:]._-' | tr ' ' '_'
}

# Function to log messages
log_message() {
    local MESSAGE=$1
    echo "$(date '+%Y-%m-%d %H:%M:%S') - $MESSAGE" | tee -a "$LOG_FILE"
}

# Clear the log file
: > "$LOG_FILE"

# Get the list of video URLs from the channel
log_message "Retrieving video list from channel: $CHANNEL_URL"
VIDEO_URLS=$(yt-dlp --flat-playlist --get-id "$CHANNEL_URL" 2>> "$LOG_FILE")
if [ $? -ne 0 ]; then
    log_message "Failed to retrieve video list from channel."
    exit 1
fi
log_message "Retrieved $(echo "$VIDEO_URLS" | wc -w) videos from the channel."

# Iterate over each video URL
for VIDEO_ID in $VIDEO_URLS; do
    VIDEO_URL="https://www.youtube.com/watch?v=$VIDEO_ID"

    # Extract the video title
    TITLE=$(yt-dlp --get-title "$VIDEO_URL" 2>> "$LOG_FILE")
    if [ $? -ne 0 ]; then
        log_message "Failed to retrieve title for video ID: $VIDEO_ID"
        continue
    fi

    # Truncate the title to the first 20 characters
    TRUNCATED_TITLE=${TITLE:0:20}

    # Sanitize the truncated title to make it a valid filename
    FILENAME=$(sanitize_filename "$TRUNCATED_TITLE").mp4

    # Log the title and the filename being used
    log_message "Downloading: $TITLE"
    log_message "Using filename: $FILENAME"

    # Download the video with the new filename
    yt-dlp -o "$FILENAME" "$VIDEO_URL" >> "$LOG_FILE" 2>&1

    if [ $? -eq 0 ]; then
        log_message "Successfully downloaded: $TITLE"
    else
        log_message "Failed to download: $TITLE"
    fi
done

log_message "Download process completed."