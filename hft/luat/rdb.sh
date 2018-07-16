export currDir=$(cd `dirname $0` && pwd)
export logDir=$currDir/log/rdb

export QINFRA=%~currDir../../../qinfra
export dependPath=$currDir/../
export initScript=$currDir/../initRdb.q

mkdir -p $logDir

$QINFRA/l32/q.sh -depend $dependPath -init $initScript -p 36041 -w 3000 1>>$logDir/stdout.log 2>>$logDir/stderr.log &