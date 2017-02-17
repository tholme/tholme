if [ -z $2 ]
do
  for i in $1-??/; do cat $i/*.jpg ;done | ffmpeg -f image2pipe -i - -crf 28 ../$2-$i.mp4
else
do
  echo "Syntax:  webcam-to-movie.sh YEAR-MONTH NAME"
  echo "Example: webcam-to-movie.sh 2009-01 arsvaagen"
  echo "Will run: for i in 2009-01-??/; do cat 2009-01/*.jpg ;done | ffmpeg -f image2pipe -i - -crf 28 ../arsvaagen-2009-01.mp4"
fi
