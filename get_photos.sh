#!/bin/bash
# Vou ter muito sucesso na programação!

function getImages() {
KEY=$1
num=$2
awk -F"[,:}]" '{for(i=1;i<=NF;i++){if($i~/'$KEY'\042/){print $(i+1)}}}' | tr -d '"' | sed -n ${num}p
}

if [ -z "$1" ]
then
  SEARCH_TERM='TRIBO'
else
  SEARCH_TERM=$1
fi

if [ -z "$2" ] 
then 
	QTY_RESULTS=3 
	echo "SETTING THE QUANTITY OF RESULTS TO 3"
elif [ $2 -lt 3 ]
then
	QTY_RESULTS=3
	echo "SETTING THE QUANTITY OF RESULTS FROM $2 TO 3"
elif [ $2 -gt 200 ]
then
	QTY_RESULTS=200
	echo "SETTING THE QUANTITY OF RESULTS FROM $2 TO 200"
else
	QTY_RESULTS=$2
	echo "SETTING THE QUANTITY OF RESULTS TO $2"
fi

SEARCH_TERM=${SEARCH_TERM//' '/'_'}
echo $SEARCH_TERM

TYPE='photo'
URL='https://pixabay.com/api'

API_KEY='13758153-7822a0290645839ed985d6278'
LANG='en'

RESPONSE=`curl -s -G -L --data-urlencode "key=$API_KEY" --data-urlencode "q=$SEARCH_TERM" --data-urlencode "image_type=photo" --data-urlencode "per_page=$QTY_RESULTS" $URL`
echo $RESPONSE | getImages webformatURL
