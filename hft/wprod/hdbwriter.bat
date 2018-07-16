set QINFRA=%~dp0..\..\..\qinfra
set dependPath=%~dp0..\
set initScript=%~dp0..\initHdbWriter.q

set logDir="%~dp0log\hdbwriter"
mkdir %logDir%

"%QINFRA%\w32\q.bat" -depend %dependPath% -init %initScript% -p 26052 -w 1000 -hdb "localhost:26051" 1>>"%logDir%/stdout.log" 2>>"%logDir%/stderr.log"