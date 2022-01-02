#!/bin/bash
bashpath=$(dirname "$(realpath $0)")

read -p "Mp4FilePath: " filepath
read -p "outputDir: " dirpath

if [ -z $dirpath ]; then
	dirpath='.'
fi

T1=() #List of clips initial time
T2=() #List of clips end time

loop='0' #Var for indicating the end of while loop
count='0' #The number of specified clips

# Prompt user for inputs
while [ $loop == 0 ]
do
	count=$(( $count + 1 ))
	read -p "Clip$count T1: " t1
	read -p "Clip$count T2: " t2
	
	T1+=($t1)
	T2+=($t2)
	
	read -p "Enough? (0 for no, 1 for yes): " loop
done

# Split the video and make outputs
mkdir $dirpath
for (( i=0; i<$count; i++ ))
do
	output="$dirpath/clip$i.mp4"
	$bashpath/cropper.sh $filepath ${T1[$i]} ${T2[$i]} $output
done

# Combine the outputs its more than one
if [ $count -gt 1 ]; then
	# Convert clips from mp4 to ts
	for (( i=0; i<$count; i++ ))
	do
		# init the input and output for converting
		mp4file="$dirpath/clip$i.mp4"
		tsfile="$dirpath/clip$i.ts"
		
		# Convert it to annexb
		$bashpath/mp4toannexb.sh $mp4file $tsfile
		
		# Remove the mp4 file
		rm $mp4file
	done
	
	# Combine clips (ts) files
	tsfiles=""
	for (( i=0; i<$count; i++ ))
	do
		tmp=" $dirpath/clip$i.ts"
		tsfiles+=$tmp
	done
	cat $tsfiles > $dirpath/output.ts
	rm $tsfiles
	
	# Convert output.ts file into mp4
	$bashpath/annexbtomp4.sh $dirpath/output.ts $dirpath/output.mp4
	rm $dirpath/output.ts
fi

echo "Done."
