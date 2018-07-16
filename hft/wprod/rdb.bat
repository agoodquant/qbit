set QINFRA=%~dp0..\..\..\qinfra
set dependPath=%~dp0..\
set initScript=%~dp0..\initRdb.q

set logDir="%~dp0log\rdb"
mkdir %logDir%

"%QINFRA%\w32\q.bat" -depend %dependPath% -init %initScript% -p 26041 -w 6000 1>>"%logDir%/stdout.log" 2>>"%logDir%/stderr.log"