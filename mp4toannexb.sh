#!/bin/bash
if [ -z $1 ] || [ -z $2 ]; then
	echo "Valid Usage: file.mp4 input.mp4 output.ts"
	exit 0
fi

INP=$1
OUT=$2

ffmpeg -i "$INP" -vcodec copy -vbsf h264_mp4toannexb -acodec copy "$OUT"
