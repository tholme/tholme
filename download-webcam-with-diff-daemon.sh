#!/bin/sh

if [ -z "$2" ]
then
  echo "Usage: `basename $0` DIRNAVN WEBCAMURL [TIME]"
  exit $E_NOARGS
fi

DIRNAVN=$1
URL="$2"
TIME=${3:-2m}
FILNAVN=`basename $URL`

cd /media/2tb/webcam/ || echo "ERROR: Can not open /media/2tb/webcam/"; exit 1
mkdir -p $DIRNAVN
cd $DIRNAVN

while true
do

  if [ -e "$FILNAVN" ]
    then
	mv "$FILNAVN" "$FILNAVN".bak.jpg
  fi

  wget --content-disposition=off -q -t 2 -N $URL

  if [ -s $FILNAVN ]
    MD5SUM=$(md5sum $FILNAVN | awk '{print $1}')
    if [ -s md5sums.txt ]
      then
	grep -q $MD5SUM md5sums.txt && exit 0
    fi
    echo $MD5SUM >> md5sums.txt

    then
	if ! diff -q "$FILNAVN" "$FILNAVN".bak.jpg > /dev/null 2>&1
  	  then
		mkdir -p `date -r $FILNAVN +%F`
		cp -p $FILNAVN `date -r $FILNAVN +%F/%F-%T.jpg`
	fi
  fi

  sleep $TIME || exit sleep failed

done
