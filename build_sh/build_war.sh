#!/bin/sh

entities=(entry)
builder_dir=/var/tmp/foo
backup_targets=(target)
build_script=/var/tmp/buidlscript.sh

suffix="_`date +%y%m%d%H%M%S`"

for i in ${entities[@]} ; do
  _link="${builder_dir}/lib/${i}"
  rm -Rf ${_link}
  ln -s "/var/tmp/lib/${i}" ${_link}
done

sed -i 's/^svn.url.base=.*/svn.url.base=svn:\/\/foo/g' "${builder_dir}/build.properties"

for i in ${backup_targets[@]} ; do
  _link_b="${builder_dir}/projects/${i}"
  if [ -e ${_link_b} ] ; then
     mv ${_link_b} "${_link_b}${suffix}"
  fi
done

chmod 777 ${build_script}
