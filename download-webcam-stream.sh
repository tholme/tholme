#!/bin/sh

if [ -z "$1" ]
then
  echo "Usage: `basename $0` DIRNAVN"
  exit $E_NOARGS
fi

#FILNAVN=`basename $1`
#DIRNAVN=`basename $1 .jpg`

#Replace / with - and set $1 as DIRNAVN
DIRNAVN="${1//\//$'-'}"

if [ ! -f "/media/2tb/webcam/$DIRNAVN/stream/url" ]; then
	echo "/media/2tb/webcam/$DIRNAVN/stream/url does not exist"
	exit 3
fi

read URL < /media/2tb/webcam/$DIRNAVN/stream/url

#Trap ctrl+c
trap trapint 2
function trapint {
    exit 0
}

cd /media/2tb/webcam/$DIRNAVN

while true
do
  MONTH=`date +%Y-%m`
  mkdir -p stream/$MONTH
  ffmpeg -loglevel warning -i "$URL" -vcodec copy -c:v copy  -c:a copy stream/$MONTH/$DIRNAVN-`date +%F-%T`.ts
  sleep 60
done
