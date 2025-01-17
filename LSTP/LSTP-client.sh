#!/bin/bash
#Client

PORT=7777
IP_SERVER="localhost"

echo "LSTP Client (Lechuga Speaker Transfer Protocol)"

echo "1. SEND HEADER"

echo "LSTP_1" | nc $IP_SERVER $PORT

echo "2. LISEN OK_HEADER"

DATA=`nc -l $PORT`

if [ "$DATA" != "OK_HEADER" ]
then
	echo "ERROR 1: Headre enviado incorrectamente "

	exit 1
fi

#cat lechuga1.lechu | text2wave -o lechuga1.wav

#ffmpeg -i lechuga1.wav lechuga1.ogg
echo "7. SEND FILE_NAME"

echo "FILE_NAME lechuga.ogg" | nc $IP_SERVER $PORT

echo "8. LISENT"

DATA=`nc -l $PORT`

if [ "$DATA" != "KO_FILE_NAME" ]
then
	echo "ERROR 2: FILE_NAME mal enviado"

	exit 2
fi

echo "12. SEND FILE DATA"

cat lechuga.ogg | nc $IP_SERVER $PORT

echo "13. LISEN"

DATA=`nc -l $PORT`

if [ "$DATA" != "OK_FILE_DATA"]
then
	echo "ERROR 3: Error al enviar datos"
	exit 3
fi

echo "Fin"

exit 0
