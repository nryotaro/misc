#!/bin/bash

pid_setting=./pid.sh

. ${pid_setting}

for i in 1 2 3; do
  target=$(sed "${i}!d" ${pid_save})
  kill ${target}
done
