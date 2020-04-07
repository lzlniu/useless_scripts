#!/bin/bash
#author:Zelin Li
#date:2020/04/06
#usage:bash igem.sh igem2019.html

input_igem_page=$1
#you have to save the igeam team page as igemXXXX.html. For example, igem 2019 track list could be from https://igem.org/Team_Tracks?year=2019 (using chrome)
grep "<a href=\"https://igem.org/Team.cgi?id=" ${input_igem_page} | sed -e 's/ //g' | sed -e 's/<ahref=\"//g' | sed -e 's/style=\"font-size:12px;line-height:15px;font-weight:600;color:blue;\">//g' | sed -e 's/<\/a>//g' | sed -e 's/"/\t/g' > list
awk -F '\t' '{print $1}' list > site
line=1
for i in $(cat site); do
	wget ${i} -O $(awk NR==${line}'{print $2}' list).html
	track=`grep "Assigned Track" $(awk NR==${line}'{print $2}' list).html | awk -F ' ' '{print $4}'`
	mv $(awk NR==${line}'{print $2}' list).html ${track}_$(awk NR==${line}'{print $2}' list).html
	let line=line+1
done
rm -rf list
rm -rf site
