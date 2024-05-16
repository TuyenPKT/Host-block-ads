







echo "Checking duplicate..."
sort source/Black-list.txt | uniq -d
sort source/White-list.txt | uniq -d
