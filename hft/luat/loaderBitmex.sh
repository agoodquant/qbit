export currDir=$(cd `dirname $0` && pwd)
export logDir=$currDir/log/loader/bitmex

export QINFRA=%~currDir../../../qinfra
export dependPath=$currDir/../
export initScript=$currDir/../initBitmex.q

mkdir -p $logDir

$QINFRA/l32/q_ssl.sh -uat -depend $dependPath -init $initScript -p 3655 -rdb "$(hostname -I):36041" -hdb "$(hostname -I):36051" -hdbwriter "$(hostname -I):36052" 1>>$logDir/stdout.log 2>>$logDir/stderr.log &