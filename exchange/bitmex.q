//////////////////////////////////////////////////////////////////////////////////////////////
//bitmex.q - contains websocket to bitmex
///
//

.qbit.bitmex.priv.instrument:`XBTUSD`XBTH18`XBTZ17`XBJZ17`BCHZ17`BCHF18`B_BLOCKSZ17`DASHZ17`DASHH18`ETHZ17`ETHH18`ETC7D`LTCZ17;

// subscribe to bitmex
.qbit.bitmex.sub:{
    .qbit.ws.connect[`.qbit.bitmex.priv.h;`:wss://www.bitmex.com; "GET /realtime HTTP/1.1\r\nHost: www.bitmex.com\r\n\r\n"; 1b];
    };

// subscribe to UAT
.qbit.bitmex.subUAT:{
    .qbit.ws.connect[`.qbit.bitmex.priv.h;`:wss://testnet.bitmex.com; "GET /realtime HTTP/1.1\r\nHost: testnet.bitmex.com\r\n\r\n"; 1b];
    };

// unsubcribe bitmex
.qbit.bitmex.unsub:{
    if[.qr.exist `.qbit.bitmex.priv.h;
        .qbit.ws.disconnect .qbit.bitmex.priv.h;
        ];
    };

// sub/unsub the order book
//@param x: boolean. 1b to sub. 0b to unsub
//@param y: instrument ticker
//
.qbit.bitmex.orderbook:{
    .qbit.ws.subJson[x;.qbit.bitmex.priv.h;.qbit.bitmex.getSubMsg[x;y;"orderBookL2"];`.qbit.bitmex.priv.orderbook];
    };

.qbit.bitmex.priv.orderbook:{[json]
    if[`table in key json;
        if[json[`table]~"orderBookL2";
            data:.qr.schema.getEmptyTbl[`bitmexOrderBookL2] uj //TODO: fix this for speed improvement
                update action:enlist json[`action], timestampServer:.z.p from json`data;
            .qbit.loader.load[`bitmexOrderBookL2;data;1b;1b;`partitioned];
            ];
        ];
    };

// sub/unsub the full order book, only top 10 levels
//@param x: boolean. 1b to sub. 0b to unsub
//@param y: instrument ticker
//
.qbit.bitmex.orderbookFull:{
    .qbit.ws.subJson[x;.qbit.bitmex.priv.h;.qbit.bitmex.getSubMsg[x;y;"orderBook10"];`.qbit.bitmex.priv.orderbookFull];
    };

.qbit.bitmex.priv.orderbookFull:{[json]
    if[`table in key json;
        if[json[`table]~"orderBook10";
            data:update bids:{flip x} each bids, asks:{flip x} each asks,
                action:enlist json[`action], timestampServer:.z.p from json`data;
            data:select symbol, bids:{first x} each bids, bidSizes:{last x} each  bids,
                asks:{first x} each asks, askSizes:{last x} each asks, timestamp:"Z"$timestamp, action, timestampServer from data;
            data:.qr.schema.getEmptyTbl[`bitmexOrderBook10] uj data;
            .qbit.loader.load[`bitmexOrderBook10;data;1b;1b;`partitioned];
            ];
        ];
    };

// sub/unsub live trades
//@param x: boolean. 1b to sub. 0b to unsub
//@param y: instrument ticker
//
.qbit.bitmex.livetrades:{
    .qbit.ws.subJson[x;.qbit.bitmex.priv.h;.qbit.bitmex.getSubMsg[x;y;"trade"];`.qbit.bitmex.priv.livetrades];
    };

.qbit.bitmex.priv.livetrades:{[json]
    if[`table in key json;
        if[json[`table]~"trade";
            data:.qr.schema.getEmptyTbl[`bitmexLivetrades] uj
                update action:enlist json[`action], timestamp:"Z"$timestamp, timestampServer:.z.p from json`data;
            .qbit.loader.load[`bitmexLivetrades;data;1b;1b;`partitioned];
            ];
        ];
    };

// sub/unsub live trades with 1 miniute bin
//@param x: boolean. 1b to sub. 0b to unsub
//@param y: instrument ticker
//
.qbit.bitmex.tradeBin1m:{
    .qbit.ws.subJson[x;.qbit.bitmex.priv.h;.qbit.bitmex.getSubMsg[x;y;"tradeBin1m"];`.qbit.bitmex.priv.tradeBin1m];
    };

.qbit.bitmex.priv.tradeBin1m:{[json]
    if[`table in key json;
        if[json[`table]~"tradeBin1m";
            data:.qr.schema.getEmptyTbl[`bitmexTradeBin1m] uj
                update action:enlist json[`action], timestamp:"Z"$timestamp, timestampServer:.z.p from json`data;
            .qbit.loader.load[`bitmexTradeBin1m;data;1b;1b;`partitioned];
            ];
        ];
    };

// sub/unsub top level quotes
//@param x: boolean. 1b to sub. 0b to unsub
//@param y: instrument ticker
//
.qbit.bitmex.quote:{
    .qbit.ws.subJson[x;.qbit.bitmex.priv.h;.qbit.bitmex.getSubMsg[x;y;"quote"];`.qbit.bitmex.priv.quote];
    };

.qbit.bitmex.priv.quote:{[json]
    if[`table in key json;
        if[json[`table]~"quote";
            data:.qr.schema.getEmptyTbl[`bitmexQuote] uj
                update action:enlist json[`action], timestamp:"Z"$timestamp, timestampServer:.z.p from json`data;
            .qbit.loader.load[`bitmexQuote;data;1b;1b;`partitioned];
            ];
        ];
    };

// sub/unsub top level quotes with 1 minute bin
//@param x: boolean. 1b to sub. 0b to unsub
//@param y: instrument ticker
//
.qbit.bitmex.quoteBin1m:{
    .qbit.ws.subJson[x;.qbit.bitmex.priv.h;.qbit.bitmex.getSubMsg[x;y;"quoteBin1m"];`.qbit.bitmex.priv.quoteBin1m];
    };

.qbit.bitmex.priv.quoteBin1m:{[json]
    if[`table in key json;
        if[json[`table]~"quoteBin1m";
            data:.qr.schema.getEmptyTbl[`bitmexQuoteBin1m] uj
                update action:enlist json[`action], timestamp:"Z"$timestamp, timestampServer:.z.p from json`data;
            .qbit.loader.load[`bitmexQuoteBin1m;data;1b;1b;`partitioned];
            ];
        ];
    };

// sub/unsub insurance fund
//@param x: boolean. 1b to sub. 0b to unsub
//
.qbit.bitmex.insurance:{
    .qbit.ws.subJson[x;.qbit.bitmex.priv.h;.qbit.bitmex.getSubMsg[x;`;"insurance"];`.qbit.bitmex.priv.insurance];
    };

.qbit.bitmex.priv.insurance:{[json]
    if[`table in key json;
        if[json[`table]~"insurance";
            data:.qr.schema.getEmptyTbl[`bitmexInsurance] uj
                update action:enlist json[`action], timestamp:"Z"$timestamp, timestampServer:.z.p from json`data;
            .qbit.loader.load[`bitmexInsurance;data;1b;1b;`partitioned];
            ];
        ];
    };

// sub/unsub server info
//@param x: boolean. 1b to sub. 0b to unsub
//
.qbit.bitmex.serverInfo:{
    .qbit.ws.subJson[x;.qbit.bitmex.priv.h;.qbit.bitmex.getSubMsg[x;`;"connected"];`.qbit.bitmex.priv.serverInfo];
    };

.qbit.bitmex.priv.serverInfo:{[json]
    if[`table in key json;
        if[json[`table]~"connected";
            if[.qr.tbl.isNonEmpty json`data;
                data:.qr.schema.getEmptyTbl[`bitmexServerInfo] uj
                    update action:enlist json[`action], timestampServer:.z.p from json`data;
                .qbit.loader.load[`bitmexServerInfo;data;1b;1b;`partitioned];
                ];
            ];
        ];
    }

// sub/unsub liquidation orders.
//@param x: boolean. 1b to sub. 0b to unsub
//@param y: instrument ticker
//
.qbit.bitmex.liquidation:{
    .qbit.ws.subJson[x;.qbit.bitmex.priv.h;.qbit.bitmex.getSubMsg[x;y;"liquidation"];`.qbit.bitmex.priv.liquidation];
    };

.qbit.bitmex.priv.liquidation:{[json]
    if[`table in key json;
        if[json[`table]~"liquidation";
            if[0 = count json`data;
                :(::);
                ];

            data:.qr.schema.getEmptyTbl[`bitmexLiquidation] uj
                update action:enlist json[`action], timestampServer:.z.p from json`data;

            if[`side in cols data;
                data:update side:{$[x~" "; ""; x]} each side from data;
                ];

            .qbit.loader.load[`bitmexLiquidation;data;1b;1b;`partitioned];
            ];
        ];
    };

// ping the server
//@param x: boolean. 1b to sub. 0b to unsub
//
.qbit.bitmex.ping:{
    neg[.qbit.bitmex.priv.h] "ping";
    };

// send the message into websocket
//@param x: boolean. 1b to sub. 0b to unsub
//@param y: instrument ticker
//@oaran z: channel
//
.qbit.bitmex.getSubMsg:{
    if[not null y;
        .qbit.bitmex.priv.checkInstrument[y];
        ];

    subUnsub:.qbit.bitmex.priv.subUnsub x;
    placeHolder:.qbit.bitmex.priv.placeHolder[z;y];

    .qbit.bitmex.priv.getMsg[subUnsub;placeHolder]
    };

// private functions
.qbit.bitmex.priv.getMsg:{
    "{", x, ",", y, "}"
    };

.qbit.bitmex.priv.subUnsub:{
    $[x;"\"op\":\"subscribe\"";"\"op\":\"unsubscribe\""]
    };

.qbit.bitmex.priv.placeHolder:{
    $[null y; "\"args\":[\"", x, "\"]";"\"args\":[\"", x, ":", .qr.type.toString[y], "\"]"]
    };

.qbit.bitmex.priv.checkInstrument:{
    if[not x in .qbit.bitmex.priv.instrument;
        .qr.throw .qr.type.toString[x], " not supported instrument in bitmex";
        ];
    };