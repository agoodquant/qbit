//////////////////////////////////////////////////////////////////////////////////////////////
//loader.q - load data into RDB/HDB
///
//

.qinfra.include["tickerplant";"ws.q"];

// init the loader
//@param rdb: rdb handle
//@param hdb: hdb handle
//
.qbit.loader.init:{[rdb;hdb;hdbwrite]
    if[not .qr.exist `.qbit.loader.priv;
        .qbit.loader.priv.toRdb:1b;
        .qbit.loader.priv.toHdb:1b;
        .qbit.loader.priv.subscriber:([] handle:"i"$(); tbl:());
        ];

    .qbit.loader.priv.rdb:rdb;
    .qbit.loader.priv.hdb:hdb;
    .qbit.loader.priv.hdbwrite:hdbwrite;
    .qbit.loader.logging[1b];
    };

// turnoff loading to RDB
//@param x: boolean. 1b to turn on; 0b to turn off
.qbit.loader.flipRdb:{
    .qbit.loader.priv.toRdb:x;
    };

// turnoff loading to HDB
//@param x: boolean. 1b to turn on; 0b to turn off
.qbit.loader.flipHdb:{
    .qbit.loader.priv.toHdb:x;
    };

// load the data into RDB/HDB
//@param t: table name
//@param data: data
//@param toRdb: boolean. load data into RDB if true
//@param toHdb: boolean. load data into HDB if true
//@param mode: hdb data format, must be either `splayed or `partitioned
.qbit.loader.load:{[t;data;toRdb;toHdb;mode]
    if[toRdb & .qbit.loader.priv.toRdb;
        .qr.trycatch[.qbit.loader.loadRdb; (t;data); {.qr.error x}];
        ];

    if[toHdb & .qbit.loader.priv.toHdb;
        .qr.trycatch[.qbit.loader.loadHdb; (t;data;mode); {.qr.error x}];
        ];

    exec {neg[z] (x;y)}[t;data] each handle from .qbit.loader.priv.subscriber where {x in y}[t] each tbl;
    };

// load the data into RDB
//@param t: table name
//@param data: data
.qbit.loader.loadRdb:{[t;data]
    .qr.remote.arpc[.qbit.loader.priv.rdb] (`.qbit.rdb.save;t;data);
    };

// load the data into HDB
//@param t: table name
//@param data: data
.qbit.loader.loadHdb:{[t;data;mode]
    .qr.remote.arpc[.qbit.loader.priv.hdbwrite] (`.qbit.hdbwriter.save;t;data;mode);
    };

// enable/disable logging
//@param x: boolean. 1b to enable; 0b to disable
.qbit.loader.logging:{
    .qbit.ws.subRaw[x;0Ni;"this is for logging";`.qr.console];
    };

// subscribe to the loader
//@param tbls: tables to sub
//
.qbit.loader.sub:{[tbls]
    `.qbit.loader.priv.subscriber insert (.z.w; tbls);
    .z.w};

// unsubscribe to the loader
//@param h: handle (integer)
//
.qbit.loader.unsub:{[h]
    delete from `.qbit.loader.priv.subscriber where handle = h;
    };

.z.pc:{
    toCLose:.qbit.loader.priv.subscriber[`handle] except key .z.W;
    delete from `.qbit.loader.priv.subscriber where handle in toCLose;
    };