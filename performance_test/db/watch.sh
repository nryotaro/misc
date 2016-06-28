#!/bin/bash

my_dir=$(dirname $(readlink -f $0))
pid_save=${my_dir}/.pid

if [ "${1}" = "start" ]; then

  LANG=C sar -u 10 999999 1>&2 > ${my_dir}/sar_db.txt &
  echo $! > ${pid_save}
  LANG=C netstat -n -i 10 1>&2 > ${my_dir}/netstat_db.txt &
  echo $! >> ${pid_save}
  LANG=C iostat 10 1>&2 > ${my_dir}/iostat_db.txt &
  echo $! >> ${pid_save} 

elif [ "${1}" = "stop" ]; then

  for i in 1 2 3; do
    target=$(sed "${i}!d" ${pid_save})
    kill ${target}
  done 

elif [ "${1}" = "check" ]; then
  ps aux |grep iostat
  ps aux |grep netstat
  ps aux |grep sar
elif [ "${1}" = "" ]; then
  echo "usage: ${0} [stop|start|check]"
fi
