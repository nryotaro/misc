conn / as sysdba

ALTER SYSTEM FLUSH BUFFER_CACHE;

EXECUTE DBMS_STATS.GATHER_TABLE_STATS (ownname=>'user',tabname=>'table',estimate_percent=>100,cascade=>TRUE,degree=>2,granularity=>'ALL');
quit;
