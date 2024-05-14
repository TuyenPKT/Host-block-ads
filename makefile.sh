#!/bin/sh

# update titles
sed -e "s/_time_stamp_/$TIME_STAMP/g" -e "s/_version_/$VERSION/g" -e "s/_domain_/$DOMAIN/g" tmp/title-Black.txt > tmp/title-Black.tmp
sed -e "s/_time_stamp_/$TIME_STAMP/g" -e "s/_version_/$VERSION/g" -e "s/_domain_/$DOMAIN/g" tmp/title-White.txt > tmp/title-White.tmp

echo "Creating hosts file..."
# create hosts files
cat tmp/title-Black.tmp source/Black-list.txt source/White-list.txt > hosts

# remove tmp file
rm -rf tmp/*.tmp
rm -rf source/*.tmp

# check duplicate
echo "Checking duplicate..."
sort source/White-list.txt | uniq -d
sort source/Black-list.txt | uniq -d
read -p "Completed! Press enter to close"




































































