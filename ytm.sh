#!/bin/bash
#By: Stnby
#1.0v
#Install these packages: curl jq wget

#Colors
N='\033[0m'
R='\033[1;31m'
G='\033[1;32m'
Y='\033[1;33m'

if [ -z "$1" ]; then
  echo -e "${R}[!]${N} Usage ./ytm.sh {URL}"
  exit
fi

#Getting video ID
if [[ $1 == *"youtu.be"* ]]; then
  ID="${1#*be/}"
elif [[ $1 == *"youtube.com"* ]]; then
  ID="${1#*v=}"
else
  echo -e "${R}[!]${N} Make sure you entered url correctly."
  exit
fi

#Removes evrything after video ID
ID="${ID:0:11}"

#Getting data
echo -e "${G}[+]${N} Getting video data...\n"
title=$(curl -s "https://noembed.com/embed?url=https://www.youtube.com/watch?v=${ID}" | jq -r '.title')
author=$(curl -s "https://noembed.com/embed?url=https://www.youtube.com/watch?v=$ID" | jq -r '.author_name')

echo -e "${G}[+]${N} Title:  $title"
echo -e "${G}[+]${N} Author: $author"
echo -e "${G}[+]${N} ID:     ${ID}\n"

if [[ $title == 'null' ]]; then
  echo -e "${R}[!]${N} Invalid video."
  exit
fi

echo -e "${G}[+]${N} Downloading MP3...${Y}"
wget "http://www.youtubeinmp3.com/fetch/?video=https://www.youtube.com/watch?v=$ID" -q --show-progress -O "${title}.mp3"

echo -e "${G}[+]${N} Done..."
