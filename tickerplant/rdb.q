//////////////////////////////////////////////////////////////////////////////////////////////
//rdb.q - realtime in memory database
///
//

// save the data into memory
//@param t: table name
//@param data: data
.qbit.rdb.save:{[t;data]
    $[.qr.exist t;t upsert data;[t set data; .qbit.rdb.priv.tbls ,: t;]];
    };

// clean up the data. only keep data for last 48 hours
.qbit.rdb.clean:{
    {delete from x where timestampServer < .z.p-03:00:00.000000000} each .qbit.rdb.priv.tbls;
    };

// init rdb
.qbit.rdb.init:{
    if[not .qr.exist`.qbit.rdb.priv.tbls;
        .qbit.rdb.priv.tbls:`$();
        ];

    .qr.timer.removeByFunctor[`.qbit.rdb.clean];
    // delete the data every 24 hour
    .qr.timer.forwardStart[`.qbit.rdb.clean;(::);"p"$.z.d+1;24000*3600];
    };