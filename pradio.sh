#!/bin/bash
# fmradio.sh
# para no confundir con el paquete radio, y modificar estaciones.

: ${DIALOG=dialog}
: ${DIALOG_SINTONIZAR=0}
: ${DIALOG_APAGAR=1}
: ${DIALOG_HELP=2}
: ${DIALOG_EXTRA=3}
: ${DIALOG_ITEM_HELP=4}
: ${DIALOG_ESC=255}

tempfile=`tempfile 2>/dev/null` || tempfile=/tmp/test$$
trap "rm -f $tempfile" 0 1 2 5 15


$DIALOG --clear --title "SINTONIZADOR DE RADIO FM PERONISTA" "$@" \
        --menu "Elija una emisora:" 20 50 17 \
        "1" "87.9 Radio UBA" \
        "2" "88.3 FM Latinos" \
        "3" "88.5" \
        "4" "89.1 FM Malena" \
        "5"  "89.3 Radio Gráfica" \
        "6"  "89.6" \
        "7"  "89.9 Radio con Vos" \
        "8"  "90.3 FM Delta" \
        "9"  "91.1 Radio Si" \
        "10"  "91.5 Radio Sol" \
        "11"  "92.1 Radio Red" \
        "12"  "92.6" \
        "13"  "92.9" \
        "14" "93.3 FM BitBox" \
        "15" "93.7" \
        "16" "93.9 Radio Palermo" \
        "17" "94.3 Radio Disney" \
        "18" "95.1 Metro" \
        "19" "95.5 FM Concepto" \
        "20" "95.9 FM Rock & Pop" \
        "21" "96.3 Radio Ciudades" \
        "22" "96.7 Nacional Clásica" \
        "23" "97.1 Radio Provincia" \
        "24" "97.5 Vale FM" \
        "25" "97.8 Retro FM" \
        "26" "98.3 Mega FM" \
        "27" "98.7 Nacional Folklórica" \
        "28" "99.1 Cadena 3" \
        "29" "99.9 La Cien" \
        "30" "100.3 La Colifata" \
        "31" "100.7 Radio Blue" \
        "32" "101.1 Radio Latina FM" \
        "33" "101.5 Radio POP" \
        "34" "102.3 FM Aspen" \
        "35" "103.6" \
        "36" "103.7" \
        "37" "103.8 FM OndaSur" \
        "38" "104.3 RQP LRL322" \
        "39" "105.5 FM Hit" \
	"40" "106.2" \
        "41" "106.7 FM Millenium" \
	"42" "107.5" 2> $tempfile

retval=$?

case $retval in
$DIALOG_SINTONIZAR)
clear
#echo Sintonizando la emisora elegida...
#echo De no reproducir active el canal Loopback en Alsamixer
#echo y elija otra emisora o seleccione Cancel para detener la radio.

case `cat $tempfile` in
1) station='87.90';;
2) station='88.30';;
3) station='88.50';;
4) station='89.10';;
5) station='89.30';;
6) station='89.60';;
7) station='89.90';;
8) station='90.30';;
9) station='91.10';;
10) station='91.50';;
11) station='92.10';;
12) station='92.60';;
13) station='92.90';;
14) station='93.30';;
15) station='93.70';;
16) station='93.90';;
17) station='94.30';;
18) station='95.10';;
19) station='95.50';;
20) station='95.90';;
21) station='96.30';;
22) station='96.70';;
23) station='97.10';;
24) station='97.50';;
25) station='97.80';;
26) station='98.30';;
27) station='98.70';;
28) station='99.10';;
29) station='99.90';;
30) station='100.30';;
31) station='100.70';;
32) station='101.10';;
33) station='101.50';;
34) station='102.30';;
35) station='103.60';;
36) station='103.70';;
37) station='103.80';;
38) station='104.30';;
39) station='105.50';;
40) station='106.20';;
41) station='106.70';;
42) station='107.20'
esac
;;

$DIALOG_APAGAR)
     fm off
amixer set 'Loopback Mixing' Disabled
     clear
echo Cerrando Perón Radio y reproducción detenida.
     exit 0;;

esac

fm on
amixer set 'Loopback Mixing' Enabled >/dev/null
exec >/dev/null 2>&1
fm $station &!
exec >/dev/tty

exec pradio.sh
