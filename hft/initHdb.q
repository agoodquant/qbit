//init script for hdb
.qinfra.load["env"];
.qinfra.load["thirdparty"];
.qinfra.load["util"];

.qr.setParams[
    .qr.param[`hdbroot; `$"data"]
    ];

.qr.setSev[`INFO];

.qinfra.include["tickerplant"; "hdb.q"];
.qbit.hdb.init[string .qr.getParam`hdbroot];