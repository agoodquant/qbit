//////////////////////////////////////////////////////////////////////////////////////////////
//hdb.q - historical database
///
//

// init the hdb
.qbit.hdb.init:{[root]
    .qbit.hdb.priv.root:$["/"=last root;-1_root;root];
    .qbit.hdb.loadDb[];
    };

// load the database
.qbit.hdb.loadDb:{
    value "\\l ", .qbit.hdb.priv.root;
    .qbit.hdb.priv.root:ssr[value "\\cd"; "\\"; "/"];
    .qr.console "hdb loaded: ", .qbit.hdb.priv.root;
    };

// show the hdb root
.qbit.hdb.getRoot:{
    .qbit.hdb.priv.root
    };

// reload the database
.qbit.hdb.reload:{
    value "\\l .";
    .qr.console "hdb reloaded";
    };