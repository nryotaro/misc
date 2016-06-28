#!/bin/sh

working_directory=/var/tmp/
scripts=(ant_build.xml)

for i in ${scripts[@]}; do
  echo Working on ${i}.
  ant -f "${working_directory}${i}"
done
