//init script for rdb
.qr.load["env"];
.qr.load["thirdparty"];
.qr.load["util"];

.qr.setSev[`INFO];

.qr.include["tickerplant";"rdb.q"];
.qbit.rdb.init[];