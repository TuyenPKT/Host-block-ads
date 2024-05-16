#!/bin/sh

echo "Making titles..."
# make time stamp & count blocked
TIME_STAMP=$(date +'%d %b %Y %H:%M')
VERSION=$(date +'%y%m%d%H%M')


sed -e "s/_time_stamp_/$TIME_STAMP/g" -e "s/_version_/$VERSION/g" tmp/title-Black.txt > tmp/title-Black.tmp
sed -e "s/_time_stamp_/$TIME_STAMP/g" -e "s/_version_/$VERSION/g" tmp/title-White.txt > tmp/title-White.tmp

echo "Creating hosts file..."
cat tmp/title-Black.tmp source/Black-list.txt > Black
cat tmp/title-White.tmp source/White-list.txt > White

echo "Checking duplicate..."
sort source/Black-list.txt | uniq -d
sort source/White-list.txt | uniq -d
