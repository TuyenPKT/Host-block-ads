#!/bin/sh

echo "Preparing files..."
# convert hosts to filters
cat source/White.txt | grep -v '#' | awk '{print $1}' > source/White.tmp
sed -i "s/www\.//g" source/White.tmp
sort -u -o source/White.tmp source/White.tmp
cat source/Black.txt | grep -v '#' | awk '{print $1}' > source/Black.tmp
sed -i "s/www\.//g" source/Black.tmp
sort -u -o source/Black.tmp source/Black.tmp


echo "Making titles..."
# make time stamp & count blocked
TIME_STAMP=$(date +'%d %b %Y %H:%M')
VERSION=$(date +'%y%m%d%H%M')
LC_NUMERIC="en_US.UTF-8"
DOMAIN_ADULT=$(printf "%'.3d\n" $(cat source/White.txt | grep -v '#' | wc -l))
DOMAIN_GAMBLING=$(printf "%'.3d\n" $(cat source/Black.txt | grep -v '#' | wc -l))

RULE_ADULT=$(printf "%'.3d\n" $(cat source/White.tmp | wc -l))
RULE_GAMBLING=$(printf "%'.3d\n" $(cat source/Black.tmp | wc -l))


# update titles
sed -e "s/_time_stamp_/$TIME_STAMP/g" -e "s/_version_/$VERSION/g" -e "s/_domain_adult_/$DOMAIN_ADULT/g" tmp/White.txt > tmp/White.tmp
sed -e "s/_time_stamp_/$TIME_STAMP/g" -e "s/_version_/$VERSION/g" -e "s/_domain_gambling_/$DOMAIN_GAMBLING/g" tmp/Black.txt > tmp/Black.tmp

sed -e "s/_time_stamp_/$TIME_STAMP/g" -e "s/_version_/$VERSION/g" -e "s/_rule_adult_/$RULE_ADULT/g" tmp/title-White.txt > tmp/title-White.tmp
sed -e "s/_time_stamp_/$TIME_STAMP/g" -e "s/_version_/$VERSION/g" -e "s/_rule_gambling_/$RULE_GAMBLING/g" tmp/title-Black.txt > tmp/title-Black.tmp

echo "Creating hosts file..."
# create hosts files
cat source/adult.txt source/adult-VN.txt | grep -v '#' | grep -v -e '^[[:space:]]*$' | awk '{print "0.0.0.0 "$1}' | sort > tmp/adult-hosts.tmp
cat source/gambling.txt source/gambling-VN.txt | grep -v '#' | grep -v -e '^[[:space:]]*$' | awk '{print "0.0.0.0 "$1}' | sort > tmp/gambling-hosts.tmp
cat source/threat.txt source/threat-VN.txt | grep -v '#' | grep -v -e '^[[:space:]]*$' | awk '{print "0.0.0.0 "$1}' | sort > tmp/threat-hosts.tmp
cat source/adult-VN.txt | grep -v '#' | grep -v -e '^[[:space:]]*$' | awk '{print "0.0.0.0 "$1}' | sort > tmp/adult-hosts-VN.tmp
cat source/gambling-VN.txt | grep -v '#' | grep -v -e '^[[:space:]]*$' | awk '{print "0.0.0.0 "$1}' | sort > tmp/gambling-hosts-VN.tmp
cat source/threat-VN.txt | grep -v '#' | grep -v -e '^[[:space:]]*$' | awk '{print "0.0.0.0 "$1}' | sort > tmp/threat-hosts-VN.tmp
cat source/ip.txt | grep -v '#' | grep -v -e '^[[:space:]]*$' | sort -n > tmp/ip.tmp

cat tmp/title-hosts-adult.tmp tmp/adult-hosts.tmp > adult/hosts
cat tmp/title-hosts-gambling.tmp tmp/gambling-hosts.tmp > gambling/hosts
cat tmp/title-hosts-threat.tmp tmp/threat-hosts.tmp > threat/hosts
cat tmp/title-hosts-adult-VN.tmp tmp/adult-hosts-VN.tmp > adult/hosts-VN
cat tmp/title-hosts-gambling-VN.tmp tmp/gambling-hosts-VN.tmp > gambling/hosts-VN
cat tmp/title-hosts-threat-VN.tmp tmp/threat-hosts-VN.tmp > threat/hosts-VN
cat tmp/title-ip.tmp tmp/ip.tmp > ip/list

echo "Creating filter file..."
# create filter files
cat source/adult.tmp source/adult-VN.tmp | grep -v -e '^[[:space:]]*$' | awk '{print "||"$1"^"}' | sort > tmp/adult-filter.tmp
cat source/gambling.tmp source/gambling-VN.tmp | grep -v -e '^[[:space:]]*$' | awk '{print "||"$1"^"}' | sort > tmp/gambling-filter.tmp
cat source/threat.tmp source/threat-VN.tmp | grep -v -e '^[[:space:]]*$' | awk '{print "||"$1"^"}' | sort > tmp/threat-filter.tmp
cat source/adult-VN.tmp | grep -v -e '^[[:space:]]*$' | awk '{print "||"$1"^"}' | sort > tmp/adult-filter-VN.tmp
cat source/gambling-VN.tmp | grep -v -e '^[[:space:]]*$' | awk '{print "||"$1"^"}' | sort > tmp/gambling-filter-VN.tmp
cat source/threat-VN.tmp | grep -v -e '^[[:space:]]*$' | awk '{print "||"$1"^"}' | sort > tmp/threat-filter-VN.tmp

cat tmp/title-filter-adult.tmp tmp/adult-filter.tmp > adult/filter.txt
cat tmp/title-filter-gambling.tmp tmp/gambling-filter.tmp > gambling/filter.txt
cat tmp/title-filter-threat.tmp tmp/threat-filter.tmp > threat/filter.txt
cat tmp/title-filter-adult-VN.tmp tmp/adult-filter-VN.tmp > adult/filter-VN.txt
cat tmp/title-filter-gambling-VN.tmp tmp/gambling-filter-VN.tmp > gambling/filter-VN.txt
cat tmp/title-filter-threat-VN.tmp tmp/threat-filter-VN.tmp > threat/filter-VN.txt

echo "Creating rule file..."
# create rule
cat source/adult.tmp source/adult-VN.tmp | awk '{print "HOST-SUFFIX,"$1",REJECT"}' > adult/quantumult-rule.conf
cat source/gambling.tmp source/gambling-VN.tmp | awk '{print "HOST-SUFFIX,"$1",REJECT"}' > gambling/quantumult-rule.conf
cat source/threat.tmp source/threat-VN.tmp | awk '{print "HOST-SUFFIX,"$1",REJECT"}' > threat/quantumult-rule.conf
cat source/adult.tmp source/adult-VN.tmp | awk '{print "DOMAIN-SUFFIX,"$1}' > adult/surge-rule.conf
cat source/gambling.tmp source/gambling-VN.tmp | awk '{print "DOMAIN-SUFFIX,"$1}' > gambling/surge-rule.conf
cat source/threat.tmp source/threat-VN.tmp | awk '{print "DOMAIN-SUFFIX,"$1}' > threat/surge-rule.conf

# check duplicate
echo "Checking duplicate..."
cat tmp/adult-hosts.tmp | uniq -d
cat tmp/gambling-hosts.tmp | uniq -d
cat tmp/threat-hosts.tmp | uniq -d
cat tmp/ip.tmp | uniq -d

# remove tmp file
rm -rf tmp/*.tmp
rm -rf source/*.tmp
read -p "Completed! Press enter to close"
