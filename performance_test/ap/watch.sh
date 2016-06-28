#!/bin/bash

my_dir=$(dirname $(readlink -f $0))
pid_save=${my_dir}/.pid
log_save=${my_dir}/.log
logs=("/var/m.log" "/var/n.log")

if [ "${1}" = "start" ]; then

  LANG=C sar -u 10 999999 1>&2 > ${my_dir}/sar_db.txt &
  echo $! > ${pid_save}
  LANG=C netstat -n -i 10 1>&2 > ${my_dir}/netstat_db.txt &
  echo $! >> ${pid_save}
  LANG=C iostat 10 1>&2 > ${my_dir}/iostat_db.txt &
  echo $! >> ${pid_save} 

  cat ${logs[0]}|wc -l >  ${log_save}
  cat ${logs[1]}|wc -l >> ${log_save}

elif [ "${1}" = "stop" ]; then
  for i in 1 2 3; do
    target=$(sed "${i}!d" ${pid_save})
    kill ${target}
  done 

  m30b=$(sed "1!d" ${log_save})
  m31b=$(sed "2!d" ${log_save})

  m30a=$(cat ${logs[0]} | wc -l)
  m31a=$(cat ${logs[1]} | wc -l)
  tail -n $((${m30a} - ${m30b})) ${logs[0]} > m30.log
  tail -n $((${m31a} - ${m31b})) ${logs[1]} > m31.log

elif [ "${1}" = "check" ]; then
  ps aux |grep iostat
  ps aux |grep netstat
  ps aux |grep sar
fi
