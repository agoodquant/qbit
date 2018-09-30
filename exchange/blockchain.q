//////////////////////////////////////////////////////////////////////////////////////////////
//blockchain.q - contains websocket to blockchain
//               blockchain: https://www.blockchain.com/
///
//

// subscribe to the blockchain by opening a websocket handle
.qbit.blockchain.sub:{
    .qbit.ws.connect[`.qbit.blockchain.priv.h;`:ws://ws.blockchain.info; "GET /inv HTTP/1.1\r\nHost: ws.blockchain.info\r\n\r\n"; 1b];
    };

// unsubcribe blockchain
.qbit.blockchain.unsub:{
    if[.qr.exist `.qbit.blockchain.priv.h;
        .qbit.ws.disconnect .qbit.blockchain.priv.h;
        ];
    };

// unconfirm transaction
.qbit.blockchain.transaction:{
    message:$[x; "{\"op\":\"unconfirmed_sub\"}"; "{\"op\":\"unconfirmed_unsub\"}"];
    .qbit.ws.subJson[x;.qbit.blockchain.priv.h;message;`.qbit.blockchain.priv.transaction];
    };

// unconfirm transaction on specific address
.qbit.blockchain.transactionOnAddr:{
    message:.j.j ("op";"addr")!($[x;"addr_sub";"add_unsub"];y);
    .qbit.ws.subJson[x;.qbit.blockchain.priv.h;message;`.qbit.blockchain.priv.transaction];
    };

.qbit.blockchain.priv.transaction:{[json]
    if[`op in key json;
        if[json[`op]~"utx";
            input:update isInput:1b from json[`x][`inputs][`prev_out];
            output:update isInput:0b from json[`x][`out];
            transact:.qr.schema.getEmptyTbl[`blockChainTransaction] uj
                delete tx_index from update transact_tx_index:tx_index from enlist delete inputs, out from json[`x];
            transactDetails: update addr:.qr.type.toString each addr, transact_tx_index:first json[`x;`tx_index] from  input, output;
            transactDetails:![transactDetails;();0b;enlist[`size]!enlist[`value]];
            transactDetails:![transactDetails;();0b;enlist[`value]];
            transactDetails:.qr.schema.getEmptyTbl[`blockChainTransactionDetails] uj transactDetails;

            transact:update timestampServer:.z.p from transact;
            transactDetails:update timestampServer:.z.p from transactDetails;
            .qbit.loader.load[`blockChainTransaction;transact;1b;1b;`partitioned];
            .qbit.loader.load[`blockChainTransactionDetails;transactDetails;1b;1b;`partitioned];
            ];
        ];
    };

// newest block being mined
.qbit.blockchain.newblock:{
    message:$[x; "{\"op\":\"blocks_sub\"}"; "{\"op\":\"blocks_unsub\"}"];
    .qbit.ws.subJson[x;.qbit.blockchain.priv.h;message;`.qbit.blockchain.priv.newblock];
    };

.qbit.blockchain.priv.newblock:{[json]
    if[`op in key json;
        if[json[`op]~"block";
            data:.qr.schema.getEmptyTbl[`blockChainBlock] uj
                enlist delete foundBy from  update description:foundBy`description, ip:foundBy`ip,
                    link:foundBy`link, time:foundBy`time, timestampServer:.z.p from json[`x];
            .qbit.loader.load[`blockChainBlock;data;1b;1b;`partitioned];
            ];
        ];
    };

// ping
.qbit.blockchain.ping:{
    neg[.qbit.blockchain.priv.h] "{\"op\":\"ping\"}";
    };

// ping latest block
.qbit.blockchain.pingLatest:{
    neg[.qbit.blockchain.priv.h] "{\"op\":\"ping_tx\"}";
    };