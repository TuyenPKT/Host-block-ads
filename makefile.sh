#!/bin/sh

echo "Preparing files..."
# convert hosts to filters
cat source/White-list.txt | grep -v '#' | awk '{print $1}' > source/White.tmp
sed -i "s/www\.//g" source/White.tmp
sort -u -o source/White.tmp source/White.tmp
cat source/Black-list.txt | grep -v '#' | awk '{print $1}' > source/Black.tmp
sed -i "s/www\.//g" source/Black.tmp
sort -u -o source/Black.tmp source/Black.tmp


echo "Making titles..."
# make time stamp & count blocked
TIME_STAMP=$(date +'%d %b %Y %H:%M')
VERSION=$(date +'%y%m%d%H%M')
LC_NUMERIC="en_US.UTF-8"
DOMAIN_ADULT=$(printf "%'.3d\n" $(cat source/White-list.txt | grep -v '#' | wc -l))
DOMAIN_GAMBLING=$(printf "%'.3d\n" $(cat source/Black-list.txt | grep -v '#' | wc -l))

RULE_ADULT=$(printf "%'.3d\n" $(cat source/White.tmp | wc -l))
RULE_GAMBLING=$(printf "%'.3d\n" $(cat source/Black.tmp | wc -l))


# update titles
sed -e "s/_time_stamp_/$TIME_STAMP/g" -e "s/_version_/$VERSION/g" -e "s/_domain_adult_/$DOMAIN_ADULT/g" tmp/White.txt > tmp/White.tmp
sed -e "s/_time_stamp_/$TIME_STAMP/g" -e "s/_version_/$VERSION/g" -e "s/_domain_gambling_/$DOMAIN_GAMBLING/g" tmp/Black.txt > tmp/Black.tmp

sed -e "s/_time_stamp_/$TIME_STAMP/g" -e "s/_version_/$VERSION/g" -e "s/_rule_adult_/$RULE_ADULT/g" tmp/title-White.txt > tmp/title-White.tmp
sed -e "s/_time_stamp_/$TIME_STAMP/g" -e "s/_version_/$VERSION/g" -e "s/_rule_gambling_/$RULE_GAMBLING/g" tmp/title-Black.txt > tmp/title-Black.tmp

echo "Creating hosts file..."
# create hosts files
cat source/White-list.txt | grep -v '#' | grep -v -e '^[[:space:]]*$' | awk '{print "0.0.0.0 "$1}' | sort > tmp/White-hosts.tmp
cat source/Black-list.txt | grep -v '#' | grep -v -e '^[[:space:]]*$' | awk '{print "0.0.0.0 "$1}' | sort > tmp/Black-hosts.tmp


cat tmp/White.tmp tmp/White-hosts.tmp > White/hosts
cat tmp/Black.tmp tmp/Black-hosts.tmp > Black/hosts


echo "Creating filter file..."
# create filter files
cat source/White.tmp | grep -v -e '^[[:space:]]*$' | awk '{print "||"$1"^"}' | sort > tmp/White-filter.tmp
cat source/Black.tmp | grep -v -e '^[[:space:]]*$' | awk '{print "||"$1"^"}' | sort > tmp/Black-filter.tmp


cat tmp/title-White.tmp tmp/White-filter.tmp > White/filter.txt
cat tmp/title-Black.tmp tmp/Black-filter.tmp > Black/filter.txt


echo "Creating rule file..."
# create rule
cat source/title-White.tmp | awk '{print "HOST-SUFFIX,"$1",REJECT"}' > White/quantumult-rule.conf
cat source/title-Black.tmp | awk '{print "HOST-SUFFIX,"$1",REJECT"}' > Black/quantumult-rule.conf


# check duplicate
echo "Checking duplicate..."
cat tmp/White-hosts.tmp | uniq -d
cat tmp/Black-hosts.tmp | uniq -d


# remove tmp file
rm -rf tmp/*.tmp
rm -rf source/*.tmp
read -p "Completed! Press enter to close"
