//init script for rdb
.qinfra.load["env"];
.qinfra.load["thirdparty"];
.qinfra.load["util"];

.qr.setSev[`INFO];

.qinfra.include["tickerplant";"rdb.q"];
.qbit.rdb.init[];