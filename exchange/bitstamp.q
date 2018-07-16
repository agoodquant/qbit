//////////////////////////////////////////////////////////////////////////////////////////////
//bitstamp.q - contains websocket to bitstamp
///
//

.qbit.bitstamp.priv.fxpairs:`btcusd`btceur`eurusd`xrpusd`xrpeur`xrpbtc`ltcusd`ltceur`ltcbtc`ethusd`etheur`ethbtc`bchusd`bcheur`bchbtc;

// subscribe to bitstamp
.qbit.bitstamp.sub:{
    .qbit.ws.connect[`.qbit.bitstamp.priv.h;`:ws://ws.pusherapp.com;
        "GET /app/de504dc5763aeef9ff52?protocol=6&client=js&version=2.1.2&flash=false HTTP/1.1\r\nHost: ws.pusherapp.com\r\n\r\n";
        1b];

    .qr.timer.removeByFunctor[`.qbit.bitstamp.ping];
    .qr.timer.start[`.qbit.bitstamp.ping;(::);1000];
    };

// unsubcribe bitstamp
.qbit.bitstamp.unsub:{
    if[.qr.exist `.qbit.bitstamp.priv.h;
        .qbit.ws.disconnect .qbit.bitstamp.priv.h;
        ];

    .qr.timer.removeByFunctor[`.qbit.bitstamp.ping];
    };

// sub/unsub the order book
//@param x: boolean. 1b to sub. 0b to unsub
//@param y: fx pair
//
.qbit.bitstamp.orderbook:{
    .qbit.ws.subJson[x;.qbit.bitstamp.priv.h;.qbit.bitstamp.getSubMsg[x;y;"order_book"];`.qbit.bitstamp.priv.orderbook];
    };

.qbit.bitstamp.priv.orderbook:{[json]
    if[(json[`event]~"data") and json[`channel]~"order_book";
        data:.j.k json[`data];
        bids:-9h$flip data[`bids];
        asks:-9h$flip data[`asks];
        data:([] bids:enlist first bids; bidSizes:enlist last bids; asks:enlist first asks; askSizes:enlist last asks; timestampServer:.z.p);
        data:.qr.schema.getEmptyTbl[`bitstampOrderBookL2] uj data;
        .qbit.loader.load[`bitstampOrderBookL2;data;1b;1b;`partitioned];
        ];
    };

// sub/unsub the full order book
//@param x: boolean. 1b to sub. 0b to unsub
//@param y: fx pair
//
.qbit.bitstamp.orderbookFull:{
    .qbit.ws.subJson[x;.qbit.bitstamp.priv.h;.qbit.bitstamp.getSubMsg[x;y;"diff_order_book"];`.qbit.bitstamp.priv.orderbookFull];
    };

.qbit.bitstamp.priv.orderbookFull:{[json]
    if[(json[`event]~"data") and json[`channel]~"diff_order_book";
        data:.j.k json[`data];
        bids:-9h$flip data[`bids];
        asks:-9h$flip data[`asks];
        ts:data[`timestamp];
        data:([] bids:enlist .qr.list.enlist first bids; bidSizes:enlist .qr.list.enlist last bids;
                 asks:enlist .qr.list.enlist first asks; askSizes:enlist .qr.list.enlist last asks;
                 timestamp:enlist ts; timestampServer:.z.p);
        data:.qr.schema.getEmptyTbl[`bitstampOrderBookFull] uj data;
        .qbit.loader.load[`bitstampOrderBookFull;data;1b;1b;`partitioned];
        ];
    };

// sub/unsub live orders
//@param x: boolean. 1b to sub. 0b to unsub
//@param y: fx pair
//
.qbit.bitstamp.liveorders:{
    .qbit.ws.subJson[x;.qbit.bitstamp.priv.h;.qbit.bitstamp.getSubMsg[x;y;"live_orders"];`.qbit.bitstamp.priv.liveorders];
    };

.qbit.bitstamp.priv.liveorders:{[json]
    if[(json[`event] like "order*") and json[`channel]~"live_orders";
        data:enlist .j.k json[`data];
        data:update event:enlist json[`event], timestampServer:.z.p from data;
        data:.qr.schema.getEmptyTbl[`bitstampLiveOrders] uj data;
        .qbit.loader.load[`bitstampLiveOrders;data;1b;1b;`partitioned];
        ];
    };

// sub/unsub live trades
//@param x: boolean. 1b to sub. 0b to unsub
//@param y: fx pair
//
.qbit.bitstamp.livetrades:{
    .qbit.ws.subJson[x;.qbit.bitstamp.priv.h;.qbit.bitstamp.getSubMsg[x;y;"live_trades"];`.qbit.bitstamp.priv.livetrades];
    };

.qbit.bitstamp.priv.livetrades:{[json]
    if[(json[`event]~"trade") and json[`channel]~"live_trades";
        data:enlist .j.k json[`data];
        data:update event:enlist json[`event], timestampServer:.z.p from data;
        data:.qr.schema.getEmptyTbl[`bitstampLiveTrades] uj data;
        .qbit.loader.load[`bitstampLiveTrades;data;1b;1b;`partitioned];
        ];
    };

// ping the server
.qbit.bitstamp.ping:{
    neg[.qbit.bitstamp.priv.h] "{\"event\" : \"pusher:ping\"}";
    };

// construct the message into websocket
//@param x: boolean. 1b to sub. 0b to unsub
//@param y: fx pair
//@oaran z: channel
//
.qbit.bitstamp.getSubMsg:{
    .qbit.bitstamp.priv.checkFx[y];

    subUnsub:.qbit.bitstmap.priv.subUnsub x;
    placeHolder:.qbit.bitstamp.priv.placeHolder[z;y];

    .qbit.bitstamp.priv.getMsg[subUnsub;placeHolder]
    };

.qbit.bitstmap.priv.subUnsub:{
    $[x;"\"event\":\"pusher:subscribe\"";"\"event\":\"pusher:unsubscribe\""]
    };

.qbit.bitstamp.priv.placeHolder:{
    $[y=`btcusd;
        "\"data\":{\"channel\":\"", x, "\"}";
        "\"data\":{\"channel\":\"", x, "_", .qr.type.toString[y], "\"}"]
    };

.qbit.bitstamp.priv.getMsg:{
    "{", x, ",", y, "}"
    };

.qbit.bitstamp.priv.checkFx:{
    if[not x in .qbit.bitstamp.priv.fxpairs;
        .qr.throw .qr.type.toString[x], " not supported fx pair in bitstmap";
        ];
    };