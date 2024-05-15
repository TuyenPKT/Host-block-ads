#!/bin/sh

echo "Making titles..."
# make time stamp & count blocked
TIME_STAMP=$(date +'%d %b %Y %H:%M')
VERSION=$(date +'%y%m%d%H%M')
LC_NUMERIC="en_US.UTF-8"

# update titles
sed -e "s/_time_stamp_/$TIME_STAMP/g" -e "s/_version_/$VERSION/g" tmp/title-Black.txt > tmp/title-Black.tmp
sed -e "s/_time_stamp_/$TIME_STAMP/g" -e "s/_version_/$VERSION/g" tmp/title-White.txt > tmp/title-White.tmp

echo "Creating hosts file..."
# create hosts files
cat tmp/title-Black.tmp source/Black-list.txt source/White-list.txt > ../hosts

# remove tmp file
rm -rf tmp/*.tmp

# check duplicate
echo "Checking duplicate..."
sort source/White-list.txt | uniq -d
sort source/Black-list.txt | uniq -d
read -p "Completed! Press enter to close"



































































