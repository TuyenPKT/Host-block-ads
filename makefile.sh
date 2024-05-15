#!/bin/sh

echo "make time stamp & count blocked..."
TIME_STAMP=$(date +'%d %b %Y %H:%M')
VERSION=$(date +'%y%m%d%H%M')
LC_NUMERIC="en_US.UTF-8"


echo "update titles..."
sed -e "s/_time_stamp_/$TIME_STAMP/g" -e "s/_version_/$VERSION/g" tmp/title-Black.txt > tmp/title-Black.tmp
sed -e "s/_time_stamp_/$TIME_STAMP/g" -e "s/_version_/$VERSION/g" tmp/title-White.txt > tmp/title-White.tmp

echo "Creating hosts file..."
cat tmp/title-Black.tmp source/Black-list.txt source/White-list.txt > hosts

echo "remove tmp file..."
rm -rf tmp/*.tmp






































































