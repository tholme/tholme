#!/bin/sh
if [ -z $2 ]
then
  echo "Syntax:  webcam-to-movie.sh YEAR-MONTH NAME"
  echo "Example: webcam-to-movie.sh 2009-01 arsvaagen"
  echo "         Will run: for i in 2009-01-??/; do cat 2009-01/*.jpg ;done | ffmpeg -f image2pipe -i - -crf 28 ../arsvaagen-2009-01.mp4"
  exit 1
fi

for i in $1-??/; do cat $i/*.jpg ;done | ffmpeg -f image2pipe -i - -crf 28 ../$2-$1.mp4

