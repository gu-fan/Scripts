#!/bin/sh

# File:	colorx.sh
# Author: rykka10(at)gmail.com
# Description: Get And Set Clipboard With Colorpicker 
# Needed: colorpicker by lilydjwg (Need Compile with libgtk2.0)
# https://dl.dropbox.com/u/1372730/code/colorpicker.c
# Needed: xsel 
#
# Input: (#RRGGBB  RRGGBB #RGB RGB )  
# Output: (#RRGGBB RRGGBB)
# e.g. #334455 55eeff 33FFEE #545 fe0
# Last Modified: April 30, 2011	


var=`xsel -o -b`

len=${#var}       

case $len in
  3)
    var=${var:0:1}${var:0:1}${var:1:1}${var:1:1}${var:2:1}${var:2:1}
    ;;
  4)
    var=${var:1:3}
    var=${var:0:1}${var:0:1}${var:1:1}${var:1:1}${var:2:1}${var:2:1}
    ;;
  7)
    var=${var:1:6}
    ;;
esac

if [[ "$var" =~ [0-9a-fA-F]{6} ]]
then
    color=`colorpicker "#$var"`
else 
    color=`colorpicker`
fi

if [ "$len" == 6 ] || [ "$len" == 3 ] 
then
  output=${color:1:6}
else
  output=${color}
fi

# set with xsel
echo -n "$output" | xsel -b -i
