//init script for hdb
.qr.load["env"];
.qr.load["thirdparty"];
.qr.load["util"];

.qr.setParams[
    .qr.param[`hdbroot; `$"data"]
    ];

.qr.setSev[`INFO];

.qr.include["tickerplant"; "hdb.q"];
.qbit.hdb.init[string .qr.getParam`hdbroot];