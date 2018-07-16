export currDir=$(cd `dirname $0` && pwd)
export logDir=$currDir/log/hdbwriter
export dataDir=$currDir/data

export QINFRA=$currDir/../../../qinfra
export dependPath=$currDir/../
export initScript=$currDir/../initHdbWriter.q

mkdir -p $logDir
mkdir -p $dataDir

$QINFRA/l32/q.sh -depend $dependPath -init $initScript -p 26052 -w 1000 -hdb "$(hostname -I):26051" 1>>$logDir/stdout.log 2>>$logDir/stderr.log &