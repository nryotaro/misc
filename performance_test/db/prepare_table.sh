#!/bin/bash

scpt_dir=$(dirname $(readlink -f $0))
c_dir=`pwd`
csvs=(csv)
tables=(tab)
init_table_script=${scpt_dir}/init.sql
port=1521
service=service
user=user
common_user=common_user
pass=pass
tmp_dir=${scpt_dir}/tmp

sqlplus ${user}/${pass}@localhost:${port}/${service} @${init_table_script}

rm -rf ${tmp_dir}
mkdir ${tmp_dir}
cd ${scpt_dir}

for i in ${csvs[@]}; do
  cd ${c_dir}
  csv=${1}/${i}.csv
  if [ ! -e ${csv} ]; then 
    continue 
  fi 
  cp ${csv} ${tmp_dir}
  cd ${scpt_dir}
  sqlldr ${user}/${pass}@localhost:${port}/${service} control=${i}.ctl
done

rm ${scpt_dir}/*.log

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
  EXECUTE DBMS_STATS.GATHER_TABLE_STATS (ownname=>'${common_user}',tabname=>'manage_table',estimate_percent=>100,cascade=>TRUE,degree=>2,granularity=>'ALL');
EOF
