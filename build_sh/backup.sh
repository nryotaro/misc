#!/bin/sh

work_dir=/var/tmp/repo

backup_targets=(foo bar bla piyo)

suffix="_`date +%y%m%d%H%M%S`"

for i in ${backup_targets[@]} ; do
  _name="${work_dir}/$i"
  if [ -e ${_name} ] ; then
    mv ${_name} "${_name}${suffix}"
  fi
done
