//init script for rdb
.qr.load["env"];
.qr.load["thirdparty"];
.qr.load["util"];

.qr.setSev[`INFO];
.qr.setLog[1;`SILENT`DEBUG`INFO];
.qr.setLog[2;`WARN`ERROR`FATAL];

.qr.include["tickerplant";"rdb.q"];
.qbit.rdb.init[];