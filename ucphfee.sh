#!/bin/bash
#author:Zelin Li
#utility:get the UCPH Msc Programs' tuition fee information
wget https://studies.ku.dk/masters/programmes/ -O programs.html
grep "<div class=\"header\"><span>.*<\/span><\/div>" programs.html | sed -e 's/<div class=\"header\"><span>//g' | sed -e 's/<\/span><\/div>//g' | sed -e 's/ /-/g' > programs.txt
for i in $(cat programs.txt); do
	wget https://studies.ku.dk/masters/${i}/application-procedure/payment-and-tuition-fees/ -O ${i}1.html
	wget https://studies.ku.dk/masters/${i}/application-procedure/non-eu-eaa-and-swiss-citizens/tuition-fee/ -O ${i}2.html
	wget https://studies.ku.dk/masters/${i}/application-procedure/non-eu-eea-and-switzerland/tuition-fees/ -O ${i}3.html
	wget https://studies.ku.dk/masters/${i}/application-procedure/non-eu--eea-and--swiss-citizens/tuition-fee-and-payment/ -O ${i}4.html
	wget https://studies.ku.dk/masters/${i}/application-procedure/non-eu-citizens/tuition-fee/ -O ${i}5.html
done
find . -name "*" -type f -size 0c | xargs -n 1 rm -f
grep -ri "DKK" *.html > UCPH-tuitionfee.txt
#rm -rf *.html
