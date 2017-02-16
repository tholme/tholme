#!/bin/bash
if [ -z "$1" ]
then
  echo "Usage: `basename $0` STRING"
  echo "Will run mksquashfs <STRING>-??/ work_dir-<STRING>.squashfs -noD && rm -rf <STRING>-??"
  exit $E_NOARGS
fi

DIRNAME=${1%/*}
MONTH=${1##*/}				#basename
MONTH=${MONTH%-}			#Remove trailing -
MONTH_VALIDATION=${MONTH//[^0-9\-]/}	#Only allow numbers and -
if [ $MONTH != $MONTH_VALIDATION ]; then
	echo "Please enter a valid directory. Has to end in 0000-00, where 0 is any number. A trailing - is also ok"
	exit 1
fi

cd $DIRNAME > /dev/null 2>&1

WORK_DIR="${PWD##*/}"

mksquashfs $MONTH-??/ "$WORK_DIR-$MONTH.squashfs" -noD -processors 1 && \
rm -rf $MONTH-??/
