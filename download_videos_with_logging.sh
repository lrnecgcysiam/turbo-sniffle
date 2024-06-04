#!/bin/bash

# Ensure yt-dlp is installed
if ! command -v yt-dlp &> /dev/null; then
    echo "yt-dlp could not be found. Please install it first."
    exit 1
fi

# Define the YouTube channel URL
CHANNEL_URL="https://www.youtube.com/channel/YOUR_CHANNEL_ID/videos"
LOG_FILE="download_videos.log"

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
VIDEO_URLS=$(yt-dlp --flat-playlist --get-id "$CHANNEL_URL")
log_message "Retrieved $(echo "$VIDEO_URLS" | wc -w) videos from the channel."

# Iterate over each video URL
for VIDEO_ID in $VIDEO_URLS; do
    VIDEO_URL="https://www.youtube.com/watch?v=$VIDEO_ID"

    # Extract the video title
    TITLE=$(yt-dlp --get-title "$VIDEO_URL")

    # Truncate the title to the first 20 characters
    TRUNCATED_TITLE=${TITLE:0:20}

    # Sanitize the truncated title to make it a valid filename
    FILENAME=$(sanitize_filename "$TRUNCATED_TITLE").mp4

    # Log the title and the filename being used
    log_message "Downloading: $TITLE"
    log_message "Using filename: $FILENAME"

    # Download the video with the new filename
    yt-dlp -o "$FILENAME" "$VIDEO_URL" | tee -a "$LOG_FILE"

    if [ $? -eq 0 ]; then
        log_message "Successfully downloaded: $TITLE"
    else
        log_message "Failed to download: $TITLE"
    fi
done

log_message "Download process completed."
