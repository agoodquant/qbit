set QINFRA=%~dp0..\..\..\qinfra
set dependPath=%~dp0..\
set initScript=%~dp0..\initBitstamp.q

set logDir="%~dp0log\loader\bitstamp"
mkdir %logDir%

"%QINFRA%\w32v35\q_ssl.bat" -depend %dependPath% -init %initScript% -p 3656 -rdb "localhost:36041" -hdb "localhost:36051" -hdbwriter "localhost:36052" 1>>"%logDir%/stdout.log" 2>>"%logDir%/stderr.log"