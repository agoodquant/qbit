//////////////////////////////////////////////////////////////////////////////////////////////
//hdbwritter.q - a q process to write data into hdb disk
///
//
.qbit.hdbwriter.init:{[hdb]
    .qbit.priv.hdb:hdb;

    if[not .qr.exist`.qbit.hdbwriter.priv.tbl;
        .qbit.hdbwriter.priv.tbl:([] tbl:"s"$(); size:"j"$(); mode:"s"$());
        ];

    .qr.timer.removeByFunctor[`.qbit.hdbwriter.write];
    // write the data every 1 hour
    .qr.timer.start[`.qbit.hdbwriter.write;1b;1000*3600];
    };

// save the data into disk and inform hdb to reload
//@param t: table name
//@param data: data
//@param mode: must be either `splayed or `partitioned
//@param delayed:
//
.qbit.hdbwriter.save:{[t;data;mode]
    .qbit.hdbwriter.priv.cache[t;data];

    $[0<> count select from .qbit.hdbwriter.priv.tbl where tbl=t;
        update size:size + -22!data from `.qbit.hdbwriter.priv.tbl where tbl = t;
        `.qbit.hdbwriter.priv.tbl upsert (t;-22!data;mode)
        ];
    .qbit.hdbwriter.write[0b];
    };

// write to hdb
//@param forced: boolean, forcefully write or not
//
.qbit.hdbwriter.write:{[forced]
    if[forced;
        .qbit.hdbwriter.chk[];
        exec .qbit.hdbwritter.priv.writeCache'[tbl;mode] from .qbit.hdbwriter.priv.tbl where size > 0;
        .qbit.notifyHdb[];
        :(::);
        ];

    tblsToWrite:exec tbl from .qbit.hdbwriter.priv.tbl where size > 1e8;
    if[0 <> count tblsToWrite;
        .qbit.hdbwriter.chk[];
        ];

    exec .qbit.hdbwritter.priv.writeCache'[tbl;mode] from .qbit.hdbwriter.priv.tbl where tbl in tblsToWrite;
    if[0<>count tblsToWrite;
        .qbit.notifyHdb[];
        ];
    };

// notify hdb
.qbit.notifyHdb:{
    .qr.console "notify hdb";
    .qr.remote.arpc[.qbit.priv.hdb] ".qbit.hdb.reload[];";
    };

.qbit.hdbwritter.priv.writeCache:{[t;mode]
    op:0b;

    if[mode=`splayed;
        op:.qr.trycatch[`.qbit.hdbwriter.splay; (t;eval t);
            {.qr.error "table ", string[x], " cannot be splayed. Error: ", y; 0b}[t]
            ];
        ];

    if[mode=`partitioned;
        op:.qr.trycatch[`.qbit.hdbwriter.partition; (t;eval t;.z.d);
            {.qr.error "table ", string[x], " cannot be partitioned. Error: ", y; 0b}[t]
            ];
        ];

    if[op;
        delete from t;
        ];
    };

.qbit.hdbwriter.priv.cache:{[t;data]
    $[.qr.exist t;t upsert data;t set data];
    };

// save the data into disk as splayed format
//@param t: table name
//@param data: data
//@return true to indicate the operation is successful
.qbit.hdbwriter.splay:{[t;data]
    targetPath:.qr.remote.rpc[.qbit.priv.hdb] ".qbit.hdb.getRoot[]";
    tbls:.qr.remote.rpc[.qbit.priv.hdb] "\\a";
    dbHandle:hsym `$targetPath;
    fhandle:hsym `$targetPath, "/", .qr.type.toString[t], "/";

    $[t in tbls; fhandle upsert .Q.en[dbHandle] data; fhandle set .Q.en[dbHandle] data];

    update size:0 from `.qbit.hdbwriter.priv.tbl where tbl = t;
    .qr.console "persist ", string[t], " in splayed format";
    1b};

// save the data into disk as partitioned format
//@param t: table name
//@param data: data
//@param dt: date for partition
//@return true to indicate the operation is successful
.qbit.hdbwriter.partition:{[t;data;dt]
    targetPath:.qr.remote.rpc[.qbit.priv.hdb] ".qbit.hdb.getRoot[]";
    tbls:.qr.remote.rpc[.qbit.priv.hdb] "\\a";
    dbHandle:hsym `$targetPath;
    fhandle:hsym `$targetPath, "/", .qr.type.toString[dt], "/",
        .qr.type.toString[t], "/";

    $[t in tbls; fhandle upsert .Q.en[dbHandle] data; fhandle set .Q.en[dbHandle] data];

    update size:0 from `.qbit.hdbwriter.priv.tbl where tbl = t;
    .qr.console "persist ", string[t], " in partitioned format";
    1b};

// batch the database by filling missing date with empty table
.qbit.hdbwriter.chk:{
    targetPath:.qr.remote.rpc[.qbit.priv.hdb] ".qbit.hdb.getRoot[]";
    dbHandle:hsym `$targetPath;
    .Q.chk[dbHandle];
    };

// list the existing hdb writer task
.qbit.hdbwriter.list:{
    .qbit.hdbwriter.priv.tbl
    };