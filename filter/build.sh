#!/bin/sh

TIME_STAMP=`date +'%d %b %Y %H:%M:%S'`
VERSION=$1
if [[ -z $VERSION ]]; then
    VERSION=`date +'%Y%m%d%H%M%S%3N'`
fi

sed -e "s/_time_stamp_/$TIME_STAMP/g" -e "s/_version_/$VERSION/g" src/Black_title.txt > src/Black_title.tmp
echo >> src/Black_title.tmp
# add to 1 file
# abpvn.txt
cat src/Black_title.tmp src/Black_list.txt > Black_list.tmp
cat Black_list.tmp White_list.txt > Hosts
echo >> Hosts
# remove tmp file
rm -rf *.tmp src/*.tmp
