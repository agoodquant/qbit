set QINFRA=%~dp0..\..\..\qinfra
set dependPath=%~dp0..\
set initScript=%~dp0..\initHdb.q

set logDir="%~dp0log\hdb"
set dataDir="%~dp0data"
mkdir %logDir%
mkdir %dataDir%

"%QINFRA%\w32\q.bat" -depend %dependPath% -init %initScript% -p 26051 -w 3000 -hdbroot "%dataDir%" 1>>"%logDir%/stdout.log" 2>>"%logDir%/stderr.log"