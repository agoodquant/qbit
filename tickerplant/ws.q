//////////////////////////////////////////////////////////////////////////////////////////////
//webscoket.q - contains websocket functinality
///
//


// transform incoming websocket message
.qbit.ws.transform:{[h;data]
    exec .qbit.ws.priv.exec[.qr.trycatch[.j.k; data;(enlist `noneJson)!enlist data]]
        each func from .qbit.ws.priv.transformFunc where (handle = h) or null handle, subType=`json;

    exec .qbit.ws.priv.exec[data]
        each func from .qbit.ws.priv.transformFunc where (handle = h) or null handle, subType=`raw;
    };

// connect to remote websocket server
//@param bridge: variable to be set to save the handle
//@param server: server handle
//@param connStr: connection string
//@param autoRespawn: boolean to indicate if websocket should be auto respawn or not
//
.qbit.ws.connect:{[bridge;server;connStr;autoRespawn]
    h:.qbit.ws.priv.getHandle[server];
    if[not null h;
        :h;
        ];

    ws:server connStr;
    if[0Ni = first ws;
        .qr.throw "err connecting to ", .qr.type.toString x;
        ];

    .qbit.ws.priv.connection:.qbit.ws.priv.connection,
        `handle`server`connStr`autoRespawn`bridge`connTime!(first ws; server; connStr; autoRespawn; bridge; .z.p);

    if[not null bridge;
        bridge set first ws;
        ];
    };

// disconnect to the remote websocket server
.qbit.ws.disconnect:{[h]
    delete from `.qbit.ws.priv.connection where handle = h;
    delete from `.qbit.ws.priv.transformFunc where handle = h;
    hclose h;
    };

// get exising handle
.qbit.ws.priv.getHandle:{
    exec first handle from .qbit.ws.priv.connection where server = x
    };

// list the websocket subscription
.qbit.ws.list:{
    .qbit.ws.priv.connection
    };

// subscribe to the webscoket handle
.qbit.ws.sub:{[sub;h;msg;func;subType]
    $[sub; .qbit.ws.priv.sub[h;func;msg;subType]; .qbit.ws.priv.unsub[h;func]];

    if[not null h;
        neg[h] msg;
        ];
    };

.qbit.ws.subJson::.qbit.ws.sub[;;;;`json];
.qbit.ws.subRaw::.qbit.ws.sub[;;;;`raw];

.qbit.ws.listen:{[sub;h;msg;func;subType]
    $[sub; .qbit.ws.priv.sub[h;func;msg;subType]; .qbit.ws.priv.unsub[h;func]];
    };

.qbit.ws.priv.sub:{[h;func;msg;subType]
    if[not .qbit.ws.exist[h;func];
        .qbit.ws.priv.transformFunc:.qbit.ws.priv.transformFunc, `handle`func`msg`subTime`subType!(h; func; msg; .z.p; subType);
        ];
    };

.qbit.ws.priv.unsub:{[h;functor]
    delete from `.qbit.ws.priv.transformFunc where handle = h, functor ~/: func;
    };

// check if functor is already sub
.qbit.ws.exist:{[h;functor]
    0 <> count select from .qbit.ws.priv.transformFunc where handle = h, functor ~/: func
    };

// list the listerns subscribe to the websocket
.qbit.ws.listListeners:{
    .qbit.ws.priv.transformFunc
    };

// empty the functors subscribe to the websocket handle
.qbit.ws.clear:{
    delete from `.qbit.ws.priv.transformFunc;
    };

// execute the functor on incoming message
.qbit.ws.priv.exec:{
    if[-11h = type y;
        :eval (y; x)
        ];

    y[x]
    };

// init the websocket subscribe list
.qbit.ws.init:{
    if[not .qr.exist`.qbit.ws.priv.connection;
        .qbit.ws.priv.connection:([] handle: "i"$(); server:"s"$(); connStr:"c"$(); autoRespawn:"b"$(); bridge:"s"$(); connTime:"p"$());
        ];

    if[not .qr.exist`.qbit.ws.priv.transformFunc;
        .qbit.ws.priv.transformFunc:([] handle:"i"$(); func:0h$(); subTime:"p"$(); msg:(); subType:"s"$());
        ];
    };

// triggered when websocket is closed
.qbit.ws.onClose:{
    // figuring out which handle was just closed
    .qbit.ws.priv.onclose each .qbit.ws.priv.connection[`handle] except key .z.W;
    };

.qbit.ws.priv.onclose:{[h]
    conn:select from .qbit.ws.priv.connection where handle = h;

    if[0 = count conn;
        :(::);
        ];

    conn:exec from conn;
    $[conn[`autoRespawn];
        [
            .qr.warn "websocket ", .qr.type.toString[conn[`server]], " accidentally closed, Reconnecting...";
            ws:conn[`server] conn`connStr;
            if[0Ni = first ws;
                delete from `.qbit.ws.priv.transformFunc where handle =h;
                .qr.throw "err re-connecting to ", .qr.type.toString[conn[`server]];
                ];

            newHandle:first ws;
            update handle:newHandle from `.qbit.ws.priv.connection where handle = h;
            update handle:newHandle from `.qbit.ws.priv.transformFunc where handle = h;

            if[not null conn[`bridge];
                conn[`bridge] set newHandle;
                ];

            exec neg[newHandle] each msg from .qbit.ws.priv.transformFunc where handle = newHandle;
            .qr.warn "websocket ", .qr.type.toString[conn[`server]], " reconnected";
        ];
        delete from `.qbit.ws.priv.transformFunc where handle = h
        ];
    }

.z.ws:{.qbit.ws.transform[.z.w; x];};

.z.wc:{.qbit.ws.onClose[];};

.qbit.ws.init[];