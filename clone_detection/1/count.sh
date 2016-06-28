#!/bin/bash

a=$(cat $1 | wc -l)
a=$(($a - $(grep -E "^====" $1 |wc -l)))
a=$(($a - $(grep -E "^Found" $1 |wc -l)))
a=$(($a - $(grep -E "^Starting" $1 |wc -l)))
echo $a

# find.exe   -type f -regex ".*\.java$" |xargs wc -l |grep total
