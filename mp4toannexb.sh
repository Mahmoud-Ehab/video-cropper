#!/bin/bash
if [ -z $1 ] || [ -z $2 ]; then
	echo "Valid Usage: ./script.sh input.mp4 output.ts"
	exit 2
fi

ffmpeg -i "$1" -vcodec copy -vbsf h264_mp4toannexb -acodec copy "$2"