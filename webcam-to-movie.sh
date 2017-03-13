#!/bin/sh
if [ -z $2 ]
then
  echo "Syntax:  webcam-to-movie.sh NAME YEAR-MONTH [YEAR-MONTH ...]"
  echo "Example: webcam-to-movie.sh arsvaagen 2009-01 2009-02 2009-03"
  echo "Will run:"
  echo "for i in 2009-01-??/; do cat 2009-01/*.jpg ;done | ffmpeg -f image2pipe -i - -crf 28 ../arsvaagen-2009-01.mp4"
  echo "for i in 2009-02-??/; do cat 2009-02/*.jpg ;done | ffmpeg -f image2pipe -i - -crf 28 ../arsvaagen-2009-02.mp4"
  echo "for i in 2009-03-??/; do cat 2009-03/*.jpg ;done | ffmpeg -f image2pipe -i - -crf 28 ../arsvaagen-2009-03.mp4"
  echo ""
  echo "Example for whole year:"
  echo "webcam-to-movie.sh arsvaagen 2011-{01..12}"
  echo ""
  exit 1
fi

#Get all arguments starting from argument 2
for MONTHS in ${@:2}
do
  #Pipe all jpeg files for one month to ffmpeg and output as mp4 file. Quality: crf 28
  for i in $MONTHS-??/; do cat $i/*.jpg ;done | ffmpeg -f image2pipe -i - -crf 28 -pix_fmt yuv420p  ../$1-$MONTHS.mp4
done

