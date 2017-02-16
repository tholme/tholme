#!/bin/sh

FIL=/home/thomas/elbil.csv

COUNTER=0
FEIL=0
EKSISTERER=0
for regnr in $@
do
  if [[ $regnr =~ ^[0-9]{5}$ ]]
  then
    if ! grep -q -m1 "EL $regnr" $FIL
    then
      CSVTEXT=`curl -s "http://www.vegvesen.no/Kjoretoy/Eie+og+vedlikeholde/Kj%C3%B8ret%C3%B8yopplysninger?registreringsnummer=EL$regnr" | \
       perl -ne '/(EL [0-9]{5}).*Merke og modell<\/th><td>(.*?)<\/td>.*Farge<\/th><td>(.*?)<\/td>.*Registrert f..?rste gang i Norge<\/th><td>(.*?)<\/td>.*Registrert f..?rste gang på eier<\/th><td>(.*?)<\/td>.*Registrert i distrikt<\/th><td>(.*?)<\/td>/ and print "$1\;$2;$3;$4;$5;$6\n";'`
    sleep 2
    if [[ -z $CSVTEXT ]]
       then
         echo -n "#"
         FEIL=$[FEIL +1]
       else
         echo $CSVTEXT >> $FIL
         echo -n .
         COUNTER=$[$COUNTER +1]
      fi
    else
      EKSISTERER=$[EKSISTERER +1]
    fi
  else
    echo -n \# >&2
  fi
done

echo -e "\nFant $COUNTER av $# elbiler i vegvesenets database, $FEIL ikke funnet. $EKSISTERER allerede i databasen"
