dpkg --get-selections | cut -f 1 | while read pkgname
do
  apt-cache depends "$pkgname" | \
  grep -E "Recommends|Suggests" | \
  cut -b 3- | \
  while read recommends
  do
    echo "$pkgname" "$recommends"
  done
done | sort -k 3 -k 2 | column -t
