#!/bin/sh
for i in $(ls -1 $HOME/webcam/*/stream/url | cut -f5 -d"/")
do
  screen -dmS $i bash -c "download-webcam-stream.sh $i"
done
