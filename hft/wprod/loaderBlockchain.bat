set QINFRA=%~dp0..\..\..\qinfra
set dependPath=%~dp0..\
set initScript=%~dp0..\initBlockchain.q

set logDir="%~dp0log\loader\blockchain"
mkdir %logDir%

"%QINFRA%\w32v35\q_ssl.bat" -depend %dependPath% -init %initScript% -p 2657 -rdb "localhost:26041" -hdb "localhost:26051" -hdbwriter "localhost:26052" 1>>"%logDir%/stdout.log" 2>>"%logDir%/stderr.log"