for i in $(cat $1); do
  for ((j=-200; j<=200; j++)) ; do
    sudo hdparm -q --read-sector $(($i+$j)) /dev/sda >/dev/null || sudo hdparm --yes-i-know-what-i-am-doing --write-sector $(($i+$j)) /dev/sda
 done
done
