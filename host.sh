#!/bin/sh

echo "Making titles..."
# make time stamp & count blocked
TIME_STAMP=$(date +'%d %b %Y %H:%M')
VERSION=$(date +'%y%m%d%H%M')

sed -e "s/_time_stamp_/$TIME_STAMP/g" -e "s/_version_/$VERSION/g" source/Black-list.txt > Black-hosts
sed -e "s/_time_stamp_/$TIME_STAMP/g" -e "s/_version_/$VERSION/g" source/White-list.txt > White-hosts

echo "Checking duplicate..."
sort source/Black-list.txt | uniq -d
sort source/White-list.txt | uniq -d
