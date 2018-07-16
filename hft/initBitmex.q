// init script of loader
.qr.load["env"];
.qr.load["thirdparty"];
.qr.load["util"];

.qr.setParams[
    .qr.param[`rdb; `$"localhost:26041"],
    .qr.param[`hdb; `$"localhost:26051"],
    .qr.param[`hdbwriter; `$"localhost:26052"]
    ];

.qr.load["exchange"];
.qr.include["tickerplant";"loader.q"];

.qbit.loader.init[
    .qr.type.toString .qr.getParam`rdb;
    .qr.type.toString .qr.getParam`hdb;
    .qr.type.toString .qr.getParam`hdbwriter
    ];

.qr.setSev[`INFO];
.qr.setLog[1;`SILENT`DEBUG`INFO];
.qr.setLog[2;`WARN`ERROR`FATAL];

//bitmex
$[`uat in key .Q.opt .z.x; .qbit.bitmex.subUAT[]; .qbit.bitmex.sub[]];
.qbit.bitmex.orderbook[1b;`XBTUSD];
.qbit.bitmex.orderbookFull[1b;`XBTUSD];
.qbit.bitmex.livetrades[1b;`XBTUSD];
.qbit.bitmex.quote[1b;`XBTUSD];
//.qbit.bitmex.instrumentInfo[1b;`XBTUSD];
.qbit.bitmex.liquidation[1b;`XBTUSD];
.qbit.bitmex.insurance[1b];
.qbit.bitmex.serverInfo[1b];