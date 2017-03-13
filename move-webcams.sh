#!/bin/sh

if [ -z "$2" ]
then
  echo "Usage: `basename $0` DIRNAVN WEBCAMURL [wait]"
  exit $E_NOARGS
fi

URL="$2"

DIRNAVN=$1
FILNAVN=`basename $URL`

mkdir -p /home/thomas/webcam/$DIRNAVN
cd /home/thomas/webcam/$DIRNAVN

wget -q -N $URL

if [ -s $FILNAVN ]
  then
    cp -p $FILNAVN `date -r $FILNAVN +%F-%T.jpg`
fi
