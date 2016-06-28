@echo off
cd /d %~dp0

rem ruby -e 'puts ("start: " + Time.new.strftime("%Y/%m/%d %H:%M:%S"))'

set resp_dir=%1
mkdir response\%resp_dir%

jmeter_msg.bat %1 msg.jmx %2 ^
  C:\program_files\apache-jmeter-2.13\bin\jmeter

rem ruby -e 'puts ("end: " + Time.new.strftime("%Y/%m/%d %H:%M:%S"))'
