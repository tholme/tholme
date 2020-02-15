#!/bin/sh
#FILENAME=$1
#OUTNAME=${FILENAME%.*}.mp4

while getopts d:o option
do
case "${option}"
in
d) MAXDEPTH=${OPTARG:-1};;
esac
done

echo $MAXDEPTH

#Delete ts files smaller than 160k
find . -type f -name "*.ts" -maxdepth ${MAXDEPTH:-1} -size -360k -delete

#Convert to mp4

find . -type f -name '*.ts' -maxdepth ${MAXDEPTH:-1} -exec sh -c '
  for file do
    OUTNAME=${file%.*}.mp4
    echo "$file -> $OUTNAME" 
    #Resets pts and set framerate to 60fps to speed up movie
    ffmpeg -hide_banner -loglevel error -i "file:$file" -c copy -f h264 - | ffmpeg -hide_banner -loglevel error -r 60 -i pipe: -vcodec copy "file:$OUTNAME"
    if [ -s "$file" ]
    then
      rm $file
    fi
  done
' sh {} +

