//init script for hdb writer
.qr.load["env"];
.qr.load["thirdparty"];
.qr.load["util"];

.qr.setParams[
    .qr.param[`hdb; `$"localhost:26051"]
    ];

.qr.setSev[`INFO];

.qr.include["tickerplant";"hdbwriter.q"];
.qbit.hdbwriter.init[string .qr.getParam`hdb];