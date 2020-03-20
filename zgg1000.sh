#!/bin/bash
#author:Zelin Li
#data:2020/03/20
#utility:get information and html page from zgg.com(the newest 1000 answers), generating url_and_tag.txt, 1000 html pages, text.txt
#usage:bash zgg1000.sh
rm -rf url_and_tag.txt
rm -rf html
rm -rf text.txt
wget "https://www.zgg.com/question?ps=1000" -O index1000.html
sed -e '/<h2 class=\"question-title\">/!d' index1000.html | sed -e 's/<h2 class=\"question-title\"><a class=\"qitem\" href=//g' | sed -e 's/target=\"_blank\">//g' | sed -e 's/<\/a><\/h2>//g' | sed -e 's/\"//g' > url_and_tag.txt
sed -e 's/https\:\/\/www.zgg.com\/question\///g' url_and_tag.txt | sed -e 's/ .*//g' > html
mkdir page
for i in $(cat html);do
	wget "https://www.zgg.com/question/${i}" -O ${i}
	sed -e '/<div class=\"answer-comm\">/,/<div class=\"answer-bottom\">/!d' ${i} | sed -e '/<p class=\"nc_ueditor_p_first\">/!d' >> text.txt
	mv ${i} page/
done
