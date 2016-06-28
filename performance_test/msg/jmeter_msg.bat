@echo off

if "%1"=="" (
  echo usage:
  echo   %0 multiplicity location_of_jmx request_size location_of_jmeter
  echo   location_of_jmeter is an optional argment.
  exit /B 1
)

set multiplicity=%1
set jmx=%2
set request_size=%3
set jmeter=jmeter

if not "%5"=="" (
  set jmeter=%5
)

%jmeter% -n ^
-t %jmx% ^
-J request.count=%request_size% ^
-J dest=%prefix_of_response_filename% ^
-J thread.count=%multiplicity%
