#!/bin/bash
if [ -z $1 ] || [ -z $2 ] || [ -z $3 ] || [ -z $4 ]; then
	echo "Valid Usage: ./script.sh src.mp4 hh:mm:ss hh:mm:ss out.mp4"
	exit 2
fi

INP=$1
OUT=$4
T1=$2
T2=$3

IFS=':' #For splitting T1 and T2

# Initialize start time list
start=()
read -a arr <<< $T1
for i in ${arr[@]};
do
	start+=($i)
done

# Initialize end time list
end=()
read -a arr <<< $T2
for i in ${arr[@]};
do
	end+=($i)
done

# Evaluate the duration between T1 and T2
# secs
if [ ${end[2]} -ge ${start[2]} ]; then
	ss=$(( 10#${end[2]} - 10#${start[2]} ))
else
	end[1]=$(( 10#${end[1]} - 1 ))
	ss=$((10#${end[2]} + 60 - 10#${start[2]}))
fi
#mins
if [ ${end[1]} -ge ${start[1]} ]; then
	mm=$(( 10#${end[1]} - 10#${start[1]} ))
else
	end[0]=$(( 10#${end[0]} - 1 ))
	mm=$(( 10#${end[1]} + 60 - 10#${start[1]} ))
fi
# hours
if [ ${end[1]} -ge ${start[1]} ]; then
	hh=$(( 10#${end[0]} - 10#${start[0]} ))
else
	exit 1
fi

if [ $ss -lt 10 ]; then ss="0$ss"; fi
if [ $mm -lt 10 ]; then mm="0$mm"; fi
if [ $hh -lt 10 ]; then hh="0$hh"; fi

dur=$hh:$mm:$ss

# Make the OUT from the INP
ffmpeg -i "$INP" -ss "$T1" -t "$dur" "$OUT"
