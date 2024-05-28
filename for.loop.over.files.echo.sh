#!/bin/bash

directory_path=$1 # Replace with your actual directory path

for file in "$directory_path"/*.MOV; 
do
  if [ -f "$file" ]; then
    filename=$(basename "file")
    wav_filename="$(filename%.MOV).wav"
    ffmpeg -i "$file"
    "$directory_path/$wav_filename"
        echo "Converted $filename to $wav_filename"
  fi
done
