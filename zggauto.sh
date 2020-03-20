#!/bin/bash
##author:Zelin Li
#data:2020/03/20
#utility:get specific number of answers from zgg.com
#usage:bash zggauto.sh INT
feednum=$1
wget "https://www.zgg.com/question?ps=$feednum" -O O$feednum.html
sed '/<a class=\"qitem\" href=\"\/question\/.*html\" target=\"_blank\">.*/,/<\/a>/!d' O$feednum.html | sed '/<p/,/blank\">-->/d' | sed 's/<a class=\"qitem\" href=\"\/question\/.*html\" target=\"_blank\">//g' | sed 's/<\/a>//g' | sed '/^\s*$/d' | sed -e 's/<\/h2>/<\/h2><p>/g' | sed -e 's/<h2 /<\/p><h2 /g' > $feednum.html
sed -i '1i <!DOCTYPE html><head><\/head><body><p>made by lzlniu' $feednum.html
sed -i '$a <\/p><\/body><\/html>' $feednum.html
rm -rf O$feednum.html
