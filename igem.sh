#!/bin/bash
#author:Zelin Li
#date:2020/04/06

grep "<a href=\"https://igem.org/Team.cgi?id=" igem2019.html | sed -e 's/ //g' | sed -e 's/<ahref=\"//g' | sed -e 's/style=\"font-size:12px;line-height:15px;font-weight:600;color:blue;\">//g' | sed -e 's/<\/a>//g' | sed -e 's/"/\t/g' > list
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

