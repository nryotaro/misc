#!/bin/sh

sqlplus user/pass << EOF > parameter.txt
  conn / as sysdba
  SHOW PARAMETER
EOF
