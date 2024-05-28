##
#
#	•	-i input.mp4: Specifies the input video file.

#•	-ss 00:00:10: Sets the start time for the trim (in this case, 10 seconds).

#•	-t 00:00:20: Sets the duration of the trimmed video (in this case, 20 seconds).
#3	•	-c copy: Copies the video and audio streams without re-encoding, which is faster and maintains quality.
#	•	output.mp4: Specifies the output file.

#Adjust the values of -ss and -t according to your desired start time and duration. If you want to trim from the beginning to a specific point, you can omit -ss and just use -t. If you want to trim from a specific point to the end, omit -t and use -ss.

#Make sure you have ffmpeg installed on your system before using this command.
#
#
ffmpeg -i $1 -ss $2 -t $3 -c copy $4
