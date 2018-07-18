////////////////////////////////////////////////////////////
/// bitmex
////////////////////////////////////////////////////////////

.qr.schema.addTbl[`bitmexOrderBookL2;
    .qr.schema.addCol[`symbol;"char"],
    .qr.schema.addCol[`id;"float"],
    .qr.schema.addCol[`side;"char"],
    .qr.schema.addCol[`size;"float"],
    .qr.schema.addCol[`price;"float"],
    .qr.schema.addCol[`action;"char"],
    .qr.schema.addCol[`timestampServer;"timestamp"]
    ];

.qr.schema.addTbl[`bitmexOrderBook10;
    .qr.schema.addCol[`symbol;"char"],
    .qr.schema.addCol[`bids;"floats"],
    .qr.schema.addCol[`bidSizes;"floats"],
    .qr.schema.addCol[`asks;"floats"],
    .qr.schema.addCol[`askSizes;"floats"],
    .qr.schema.addCol[`timestamp;"datetime"],
    .qr.schema.addCol[`action;"char"],
    .qr.schema.addCol[`timestampServer;"timestamp"]
    ];

.qr.schema.addTbl[`bitmexLivetrades;
    .qr.schema.addCol[`timestamp;"datetime"],
    .qr.schema.addCol[`symbol;"char"],
    .qr.schema.addCol[`side;"char"],
    .qr.schema.addCol[`size;"float"],
    .qr.schema.addCol[`price;"float"],
    .qr.schema.addCol[`tickDirection;"char"],
    .qr.schema.addCol[`trdMatchID;"char"],
    .qr.schema.addCol[`grossValue;"float"],
    .qr.schema.addCol[`homeNotional;"float"],
    .qr.schema.addCol[`foreignNotional;"float"],
    .qr.schema.addCol[`action;"char"],
    .qr.schema.addCol[`timestampServer;"timestamp"]
    ];


.qr.schema.addTbl[`bitmexTradeBin1m;
    .qr.schema.addCol[`timestamp;"datetime"],
    .qr.schema.addCol[`symbol;"char"],
    .qr.schema.addCol[`open;"float"],
    .qr.schema.addCol[`high;"float"],
    .qr.schema.addCol[`low;"float"],
    .qr.schema.addCol[`close;"float"],
    .qr.schema.addCol[`trades;"float"],
    .qr.schema.addCol[`volume;"float"],
    .qr.schema.addCol[`vwap;"float"],
    .qr.schema.addCol[`lastSize;"float"],
    .qr.schema.addCol[`turnover;"float"],
    .qr.schema.addCol[`homeNotional;"float"],
    .qr.schema.addCol[`foreignNotional;"float"],
    .qr.schema.addCol[`action;"char"],
    .qr.schema.addCol[`timestampServer;"timestamp"]
    ];

.qr.schema.addTbl[`bitmexQuote;
    .qr.schema.addCol[`timestamp;"datetime"],
    .qr.schema.addCol[`symbol;"char"],
    .qr.schema.addCol[`bidSize;"float"],
    .qr.schema.addCol[`bidPrice;"float"],
    .qr.schema.addCol[`askPrice;"float"],
    .qr.schema.addCol[`askSize;"float"],
    .qr.schema.addCol[`action;"char"],
    .qr.schema.addCol[`timestampServer;"timestamp"]
    ];

.qr.schema.addTbl[`bitmexQuoteBin1m;
    .qr.schema.addCol[`timestamp;"datetime"],
    .qr.schema.addCol[`symbol;"char"],
    .qr.schema.addCol[`bidSize;"float"],
    .qr.schema.addCol[`bidPrice;"float"],
    .qr.schema.addCol[`askPrice;"float"],
    .qr.schema.addCol[`askSize;"float"],
    .qr.schema.addCol[`action;"char"],
    .qr.schema.addCol[`timestampServer;"timestamp"]
    ];

.qr.schema.addTbl[`bitmexLiquidation;
    .qr.schema.addCol[`orderID;"char"],
    .qr.schema.addCol[`symbol;"char"],
    .qr.schema.addCol[`side;"char"],
    .qr.schema.addCol[`price;"float"],
    .qr.schema.addCol[`leavesQty;"float"]
    ];

.qr.schema.addTbl[`bitmexInsurance;
    .qr.schema.addCol[`currency;"char"],
    .qr.schema.addCol[`timestamp;"char"],
    .qr.schema.addCol[`walletBalance;"float"],
    .qr.schema.addCol[`action;"char"],
    .qr.schema.addCol[`timestampServer;"timestamp"]
    ];

.qr.schema.addTbl[`bitmexServerInfo;
    .qr.schema.addCol[`users;"float"],
    .qr.schema.addCol[`bots;"float"],
    .qr.schema.addCol[`action;"char"],
    .qr.schema.addCol[`timestampServer;"timestamp"]
    ];

////////////////////////////////////////////////////////////
/// bitstamp
////////////////////////////////////////////////////////////

.qr.schema.addTbl[`bitstampOrderBookL2;
    .qr.schema.addCol[`bids;"floats"],
    .qr.schema.addCol[`bidSizes;"floats"],
    .qr.schema.addCol[`asks;"floats"],
    .qr.schema.addCol[`askSizes;"floats"],
    .qr.schema.addCol[`timestamp;"timestamp"],
    .qr.schema.addCol[`timestampServer;"timestamp"]
    ];

.qr.schema.addTbl[`bitstampOrderBookFull;
    .qr.schema.addCol[`bids;"floats"],
    .qr.schema.addCol[`bidSizes;"floats"],
    .qr.schema.addCol[`asks;"floats"],
    .qr.schema.addCol[`askSizes;"floats"],
    .qr.schema.addCol[`timestamp;"timestamp"],
    .qr.schema.addCol[`timestampServer;"timestamp"]
    ];

.qr.schema.addTbl[`bitstampLiveOrders;
    .qr.schema.addCol[`price;"float"],
    .qr.schema.addCol[`amount;"float"],
    .qr.schema.addCol[`datetime;"timestamp"],
    .qr.schema.addCol[`id;"float"],
    .qr.schema.addCol[`order_type;"float"],
    .qr.schema.addCol[`event;"char"],
    .qr.schema.addCol[`microtimestamp;"timestamp"],
    .qr.schema.addCol[`timestampServer;"timestamp"]
    ];

.qr.schema.addTbl[`bitstampLiveTrades;
    .qr.schema.addCol[`amount;"float"],
    .qr.schema.addCol[`buy_order_id;"float"],
    .qr.schema.addCol[`sell_order_id;"float"],
    .qr.schema.addCol[`amount_str;"char"],
    .qr.schema.addCol[`price_str;"char"],
    .qr.schema.addCol[`timestamp;"timestamp"],
    .qr.schema.addCol[`price;"float"],
    .qr.schema.addCol[`type;"float"],
    .qr.schema.addCol[`id;"float"],
    .qr.schema.addCol[`timestampServer;"timestamp"]
    ];

////////////////////////////////////////////////////////////
/// blockchain
////////////////////////////////////////////////////////////

.qr.schema.addTbl[`blockChainBlock;
    .qr.schema.addCol[`txIndexes;"floats"],
    .qr.schema.addCol[`nTx;"float"],
    .qr.schema.addCol[`totalBTCSent;"float"],
    .qr.schema.addCol[`estimatedBTCSent;"float"],
    .qr.schema.addCol[`reward;"float"],
    .qr.schema.addCol[`size;"float"],
    .qr.schema.addCol[`weight;"float"],
    .qr.schema.addCol[`blockIndex;"float"],
    .qr.schema.addCol[`prevBlockIndex;"float"],
    .qr.schema.addCol[`height;"float"],
    .qr.schema.addCol[`hash;"char"],
    .qr.schema.addCol[`mrklRoot;"char"],
    .qr.schema.addCol[`version;"float"],
    .qr.schema.addCol[`time;"float"],
    .qr.schema.addCol[`bits;"float"],
    .qr.schema.addCol[`nonce;"float"],
    .qr.schema.addCol[`description;"char"],
    .qr.schema.addCol[`ip;"char"],
    .qr.schema.addCol[`link;"char"],
    .qr.schema.addCol[`timestampServer;"timestamp"]
    ];

.qr.schema.addTbl[`blockChainTransaction;
    .qr.schema.addCol[`lock_time;"float"],
    .qr.schema.addCol[`ver;"float"],
    .qr.schema.addCol[`size;"float"],
    .qr.schema.addCol[`time;"float"],
    .qr.schema.addCol[`vin_sz;"float"],
    .qr.schema.addCol[`hash;"char"],
    .qr.schema.addCol[`vout_sz;"float"],
    .qr.schema.addCol[`relayed_by;"char"],
    .qr.schema.addCol[`transact_tx_index;"float"],
    .qr.schema.addCol[`timestampServer;"timestamp"]
    ];

.qr.schema.addTbl[`blockChainTransactionDetails;
    .qr.schema.addCol[`spent;"boolean"],
    .qr.schema.addCol[`tx_index;"float"],
    .qr.schema.addCol[`type;"float"],
    .qr.schema.addCol[`addr;"char"],
    .qr.schema.addCol[`size;"float"],
    .qr.schema.addCol[`n;"float"],
    .qr.schema.addCol[`script;"char"],
    .qr.schema.addCol[`isInput;"boolean"],
    .qr.schema.addCol[`transact_tx_index;"float"],
    .qr.schema.addCol[`timestampServer;"timestamp"]
    ];