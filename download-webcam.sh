#!/bin/sh

if [ -z "$2" ]
then
  echo "Usage: `basename $0` DIRNAVN WEBCAMURL [wait]"
  exit $E_NOARGS
fi

#FILNAVN=`basename $1`
#DIRNAVN=`basename $1 .jpg`

DIRNAVN=$1
URL="$2"
FILNAVN=`basename $URL`

if [ "$3" = "wait" ]
then
  sleep 30
fi

mkdir -p $HOME/webcam/$DIRNAVN
cd $HOME/webcam/$DIRNAVN

if [ -s "$FILNAVN" ]
then
	mv "$FILNAVN" "$FILNAVN".bak
fi

wget -q -t 2 -N $URL

if [ -s $FILNAVN ]
  then
	mkdir -p `date -r $FILNAVN +%F`
	cp -p $FILNAVN `date -r $FILNAVN +%F/%F-%T.jpg`
fi
