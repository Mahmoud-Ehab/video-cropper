# Abstract
A Mini bash script program for cropping mp4 videos immediately using [FFmpeg](https://github.com/FFmpeg/FFmpeg).

# Usage
Execute the `main.sh` file by either using bash or making it executable using chmod.
```s
$ bash main.sh
```
or
```s
$ chmod +x main.sh
$ ./main.sh
```

Then it will prompt you for two main inputs:
- The mp4 file path.
- And directory path for output (You can just press enter here, and "./" will be used as default value)
```s
$ bash main.sh
Mp4FilePath: /home/Videos/foo.mp4
outputDir: 
...
```

Next the `main.sh` will enter a while loop allowing you to specify your clips with two inputs for each one, T1 and T2. Whereas T1 indicates the begining of the clip, and T2 is the end. The both T1 & T2 should be in the following form `hh:mm:ss`.

Once you write T1 & T2 for a clip, you'll be prompted to input either 0 or 1 for recursive purpose.
```s
Mp4FilePath: /home/Videos/foo.mp4
outputDir: 
Clip1 T1: 00:00:00
Clip1 T2: 00:00:55
Enough? (0 for no, 1 for yes): 0

Clip2 T1: 00:01:15
Clip2 T2: 00:02:59
Enough? (0 for no, 1 for yes): 1
...
```
> All outputs (clips) will be eventually automatically into one file. In other words, the output is allways one condensed mp4 file.