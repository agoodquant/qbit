export currDir=$(cd `dirname $0` && pwd)
export logDir=$currDir/log/hdb
export dataDir=$currDir/data

export QINFRA=$currDir/../../../qinfra
export dependPath=$currDir/../
export initScript=$currDir/../initHdb.q

mkdir -p $logDir
mkdir -p $dataDir

$QINFRA/l32/q.sh -depend $dependPath -init $initScript -p 26051 -w 3000 -hdbroot $dataDir 1>>$logDir/stdout.log 2>>$logDir/stderr.log &