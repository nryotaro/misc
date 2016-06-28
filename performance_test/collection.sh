#!/bin/bash

ap=apuser@104.203.77.4:/foo
db=oraclem@104.203.77.5:/bar

for i in "a.txt" "a.log" "b.txt" "c.txt" "b.log"; do
  mkdir -p $1
  scp ${ap}/${i} $1
done

for i in "foo" "bar" "piyo" ; do
  scp ${db}/${i} $1
done
