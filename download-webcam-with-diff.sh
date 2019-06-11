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
FILNAVN=`basename $URL`

mkdir -p $HOME/webcam/$DIRNAVN
cd $HOME/webcam/$DIRNAVN

if [ -e "$FILNAVN" ]
  then
	mv "$FILNAVN" "$FILNAVN".bak.jpg
fi

wget --content-disposition=off -q -t 2 -N $URL

if [ -s $FILNAVN ]
  then
  	MD5SUM=$(openssl md5 $FILNAVN | awk '{print $2}')
	if [ -s md5sums.txt ]
	  then
		grep -q $MD5SUM md5sums.txt && exit 0
	fi
	echo $MD5SUM >> md5sums.txt
	if ! diff -q "$FILNAVN" "$FILNAVN".bak.jpg > /dev/null 2>&1
  	  then
		mkdir -p `date -r $FILNAVN +%F`
		cp -p $FILNAVN `date -r $FILNAVN +%F/%F-%T.jpg`
	fi
fi
