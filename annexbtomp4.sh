#!/bin/bash
if [ -z $1 ] || [ -z $2 ]; then
	echo "Valid Usage: file.ts input.mp4 output.mp4"
	exit 0
fi

INP=$1
OUT=$2

ffmpeg -y -i "$1" -acodec copy -ar 44100 -ab 96k -coder ac -vbsf h264_mp4toannexb "$2"
