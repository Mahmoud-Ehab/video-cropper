#!/bin/bash
if [ -z $1 ] || [ -z $2 ]; then
	echo "Valid Usage: ./script.sh input.mp4 output.ts"
	exit 2
fi

INP=$1
OUT=$2

ffmpeg -i "$INP" -vcodec copy -vbsf h264_mp4toannexb -acodec copy "$OUT"
