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


//bitstamp
.qbit.blockchain.sub[];
.qbit.blockchain.transaction[1b];
.qbit.blockchain.newblock[1b];