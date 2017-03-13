#!/bin/sh

if [ -z "$2" ]
then
  echo "Usage: `basename $0` DIRNAVN WEBCAMURL"
  exit $E_NOARGS
fi

#FILNAVN=`basename $1`
#DIRNAVN=`basename $1 .jpg`

DIRNAVN=$1
URL="$2"

#Trao ctrl+x
trap trapint 2
function trapint {
    exit 0
}

mkdir -p /home/thomas/webcam/$DIRNAVN/stream
cd /home/thomas/webcam/$DIRNAVN

while true
do
  ffmpeg -loglevel warning -i "$2" -c:v copy  -c:a copy stream/$DIRNAVN-`date +%F-%T`.ts
  sleep 1
done
