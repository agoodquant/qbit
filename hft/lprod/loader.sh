export currDir=$(cd `dirname $0` && pwd)

$currDir/loaderBitmex.sh
$currDir/loaderBitstamp.sh
$currDir/loaderBlockchain.sh