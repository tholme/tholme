#!/bin/sh

if [ -z "$2" ]
then
  echo "Usage: `basename $0` DIRNAVN WEBCAMURL [rand]"
  exit $E_NOARGS
fi

#FILNAVN=`basename $1`
#DIRNAVN=`basename $1 .jpg`
RANDOM=`head -c4 /dev/urandom | od -N4 -tu4 | sed -ne '1s/.* //p'`
if [ "$3" = 'rand' ]
then
  URL="$2?t=$RANDOM"
else
  URL="$2"
fi
if [ "$3" = "wait" ]
then
  sleep 30
fi

DIRNAVN=$1
FILNAVN=`basename $URL`

mkdir -p /home/thomas/webcam/$DIRNAVN
cd /home/thomas/webcam/$DIRNAVN

if [ "`basename $2`" = "$FILNAVN" ]
then
  sleep 0.001
else
  mv `basename $2` $FILNAVN
fi

wget -q -N $URL

if [ -s $FILNAVN ]
  then
    cp -p $FILNAVN `date -r $FILNAVN +%F-%T.jpg`
fi
if [ "`basename $2`" = "$FILNAVN" ]
then
  sleep 0.0001
else
  mv $FILNAVN `basename $2`
fi
