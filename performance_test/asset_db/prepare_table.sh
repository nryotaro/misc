#!/bin/bash

csvs=(csv_)
tables=(tab)
init_table_script=init.sql
port=1521
service=serve
user=user
common_user=common_user
pass=oss

pid_setting=./pid.sh

sqlplus ${user}/${pass}@localhost:${port}/${service} @${init_table_script}
rm -rf tmp
mkdir tmp

for i in ${csvs[@]}; do
  if [ ! -e ${1}/${i}.csv ]; then 
    continue 
  fi 
  cp ${1}/${i}.csv tmp
  sqlldr ${user}/${pass}@localhost:${port}/${service} control=${i}.ctl
done

rm *.log
rm -rf tmp

sqlplus ${user}/${pass}@localhost:${port}/${service} << EOF
  conn / as sysdba
  ALTER SYSTEM FLUSH BUFFER_CACHE;
EOF

for table in ${tables[@]}; do
  sqlplus ${user}/${pass}@localhost:${port}/${service} << EOF
    EXECUTE DBMS_STATS.GATHER_TABLE_STATS (ownname=>'${user}',tabname=>'${table}',estimate_percent=>100,cascade=>TRUE,degree=>2,granularity=>'ALL');
EOF
done

sqlplus ${common_user}/${pass}@localhost:${port}/${service} << EOF
  EXECUTE DBMS_STATS.GATHER_TABLE_STATS (ownname=>'${common_user}',tabname=>'table_foobar',estimate_percent=>100,cascade=>TRUE,degree=>2,granularity=>'ALL');
EOF


. ${pid_setting}
suffix=$(echo _${1} |sed -E "s/\//_/g")

sar -u 10 999999 1>&2 > sar${suffix}.txt &
echo $! > ${pid_save}
netstat -n -i 10 1>&2 > netstat${suffix}.txt &
echo $! >> ${pid_save}
iostat 10 1>&2 > iostat${suffix}.txt &
echo $! >> ${pid_save}

