export currDir=$(cd `dirname $0` && pwd)
export logDir=$currDir/log/loader/blockchain

export QINFRA=%~currDir../../../qinfra
export dependPath=$currDir/../
export initScript=$currDir/../initBlockchain.q

mkdir -p $logDir

$QINFRA/l32/q_ssl.sh -depend $dependPath -init $initScript -p 2657 -rdb "$(hostname -I):26041" -hdb "$(hostname -I):26051" -hdbwriter "$(hostname -I):26052" 1>>$logDir/stdout.log 2>>$logDir/stderr.log &