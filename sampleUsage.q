//loading
.qinfra.loadDep[`exchange;"Q:/qbit/exchange"]
.qinfra.listDep[]

.qinfra.load["thirdparty"];
.qinfra.load["env"];
.qinfra.load["util"];
.qinfra.listModule[]

//////////////////////////////////////////
// loader
/////////////////////////////////////////
.qinfra.load["exchange"];
.qinfra.include["tickerplant";"loader.q"];
.qbit.loader.init["localhost:26041";"localhost:26051";"localhost:26052"];
.qr.setSev[`INFO];
//.qr.setSev[`SILENT]
//.qr.setSevConsole[]
.qr.setLog["C:/Users/user/Desktop/Document/dev/KDB+/log/qbit/loader/stdout.log";`SILENT`DEBUG`INFO];
.qr.setLog["C:/Users/user/Desktop/Document/dev/KDB+/log/qbit/loader/stderr.log";`WARN`ERROR`FATAL];
.qbit.loader.flipRdb[0b]
.qbit.loader.flipHdb[0b]

// block chain
.qbit.blockchain.sub[];
.qbit.blockchain.ping[];
.qbit.blockchain.pingLatest[];
.qbit.blockchain.transaction[1b];
.qbit.blockchain.transaction[0b];
.qbit.blockchain.pending[1b];
.qbit.blockchain.pending[0b];
.qbit.blockchain.newblock[1b];
.qbit.blockchain.newblock[0b];

//bitstamp
.qbit.bitstamp.sub[];
.qbit.bitstamp.orderbook[1b;`btcusd];
.qbit.bitstamp.orderbook[0b;`btcusd];
.qbit.bitstamp.orderbookFull[1b;`btcusd];
.qbit.bitstamp.orderbookFull[0b;`btcusd];
.qbit.bitstamp.liveorders[1b;`btcusd];
.qbit.bitstamp.liveorders[0b;`btcusd];
.qbit.bitstamp.livetrades[1b;`btcusd];
.qbit.bitstamp.livetrades[0b;`btcusd];
.qbit.bitstamp.unsub[];

//bitmex
(-26!())[]
.qbit.bitmex.sub[];
.qbit.bitmex.subUAT[];
.qbit.bitmex.ping[];
.qbit.bitmex.orderbook[1b;`XBTUSD];
.qbit.bitmex.orderbook[0b;`XBTUSD];
.qbit.bitmex.orderbookFull[1b;`XBTUSD];
.qbit.bitmex.orderbookFull[0b;`XBTUSD];
.qbit.bitmex.livetrades[1b;`XBTUSD];
.qbit.bitmex.livetrades[0b;`XBTUSD];
.qbit.bitmex.tradeBin1m[1b;`XBTUSD];
.qbit.bitmex.tradeBin1m[0b;`XBTUSD];
.qbit.bitmex.quote[1b;`XBTUSD];
.qbit.bitmex.quote[0b;`XBTUSD];
.qbit.bitmex.quoteBin1m[1b;`XBTUSD];
.qbit.bitmex.quoteBin1m[0b;`XBTUSD];
.qbit.bitmex.instrumentInfo[1b;`XBTUSD];
.qbit.bitmex.instrumentInfo[0b;`XBTUSD];
.qbit.bitmex.liquidation[1b;`XBTUSD];
.qbit.bitmex.liquidation[0b;`XBTUSD];
.qbit.bitmex.insurance[1b];
.qbit.bitmex.insurance[0b];
.qbit.bitmex.serverInfo[1b];
.qbit.bitmex.serverInfo[0b];
.qbit.bitmex.unsub[];

// blockchain
.qbit.blockchain.sub[];
.qbit.blockchain.ping[];
.qbit.blockchain.pingLatest[];
.qbit.blockchain.transactionOnAddr[1b;"1P9RQEr2XeE3PEb44ZE35sfZRRW1JHU8qx"];
.qbit.blockchain.transactionOnAddr[0b;"1P9RQEr2XeE3PEb44ZE35sfZRRW1JHU8qx"];
.qbit.blockchain.transaction[1b];
.qbit.blockchain.transaction[0b];
.qbit.blockchain.newblock[1b];
.qbit.blockchain.newblock[0b];
.qbit.blockchain.unsub[];

//////////////////////////////////////////
// rdb
/////////////////////////////////////////
.qinfra.include[("tickerplant";"rdb.q")];
.qbit.rdb.clean[];

// bitmex
bitmexOrderBookL2
bitmexOrderBook10
bitmexLivetrades
bitmexTradeBin1m
bitmexQuote
bitmexQuoteBin1m
bitmexInstrumentInfo
bitmexInsurance
bitmexServerInfo
bitmexLiquidation

// bitstamp
bitstampOrderBookL2
bitstampOrderBookFull
bitstampLiveOrders
bitstampLiveTrades

// blockchain
blockChainBlock
blockChainTransaction
blockChainTransactionDetails

//////////////////////////////////////////
// hdb
/////////////////////////////////////////
.qinfra.include[("tickerplant";"hdb.q")];
.qbit.hdb.init["c:/Users/user/Desktop/Document/dev/KDB+/data"]

//////////////////////////////////////////
// hdbwriter
/////////////////////////////////////////
.qinfra.include[("tickerplant";"hdbwriter.q")];
.qbit.hdbwriter.init["localhost:26051"];
.qbit.hdbwriter.splay[`test2;([] a:1 2 3f; b:`r`d`b)]
.qbit.hdbwriter.partition[`test2;([] a:1 2 3f; b:`r`d`b);.z.d-1];
.qbit.hdbwriter.save[`test;([] a:1 2 3f; b:`r`d`b);`splayed];
.qbit.hdbwriter.save[`test2;([] a:1 2 3f; b:`r`d`b);`partitioned];
.qbit.hdbwriter.write[1b]
.qbit.hdbwriter.chk[]

//////////////////////////finish//////////////////////////////////////

// followings are test codes on loader
.qbit.loader.loadRdb[`test;([] a:1 2 3f; b:`r`d`b)];
.qbit.loader.loadHdb[`test2;([] a:1 2 3f; b:`r`d`b);`partitioned];
.qbit.loader.load[`test2;([] a:1 2 3f; b:`r`d`b);1b;1b;`partitioned];
.qbit.ws.clear[];
.qbit.ws.sub[1b;{0N!x;}]
.qbit.ws.sub[0b;{0N!x;}]
.qbit.ws.listListeners[]
test:{0N!x;};
.qbit.ws.sub[1b;`test]
.qbit.ws.sub[0b;`test]
.qbit.ws.transform "hello"
.qr.timer.list[]
.qbit.bitmex.ping[]
.qbit.bitstamp.ping[]
.qbit.blockchain.ping[]
.qbit.ws.list[]

// test qbit subscriber
h:.qr.remote.arpc["localhost:2655"] (`.qbit.loader.sub;`bitmexOrderBookL2`bitmexOrderBook10)
h:.qr.remote.rpc["localhost:2655"] (`.qbit.loader.unsub;h)
.qr.remote.rpc["localhost:2655"] ".qbit.loader.priv.subscriber"
