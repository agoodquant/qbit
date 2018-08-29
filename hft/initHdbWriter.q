//init script for hdb writer
.qinfra.load["env"];
.qinfra.load["thirdparty"];
.qinfra.load["util"];

.qr.setParams[
    .qr.param[`hdb; `$"localhost:26051"]
    ];

.qr.setSev[`INFO];

.qinfra.include["tickerplant";"hdbwriter.q"];
.qbit.hdbwriter.init[string .qr.getParam`hdb];