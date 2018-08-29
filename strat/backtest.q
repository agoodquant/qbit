.qinfra.loadDep[`quant;"Q:/qr/quant"];

.qinfra.load["env")];
.qinfra.load["thirdparty"];
.qinfra.load["util"];
.qinfra.load["quant"];


.qinfra.listModule[]
.qr.ns.ls[`.qr]

.qr.remote.rpc["localhost:26041"] "key `."

bitmexLivetrades:.qr.remote.rpc["localhost:26041"] "bitmexLivetrades"

bitmexLivetrades:update "Z"$timestamp from bitmexLivetrades

select timestamp, price from bitmexLivetrades

5000#bitmexLivetrades

select sum size by side from bitmexLivetrades

vwap:update total:sum each size from select timestamp:last timestamp,vwap: size wavg price,size by g:1000 xbar sums size from bitmexLivetrades

select timestamp, vwap from vwap

rvwap : { [t;size_par]
    // add the bucket and the total size
    t:update bar:size_par xbar tot from update tot:sums size from t;
    // get the indices where the bar changes
    ind:where differ t`bar;
    // re-index t, and sort (duplicate the rows where the bucket changes)
    t:t asc (til count t),ind;
    // shift all the indices due to the table now being larger
    ind:ind+til count ind;
    // update the size in the first trade of the new window and modify the bar
    t:update size:size-tot-bar,bar:size_par xbar tot-size from t where i in ind;
    // update the size in the second trade of the new window
    t:update size:tot-bar from t where i in 1+ind;
    // calculate stats
    select last timestamp ,price:size wavg price,sum size by bar from t
    };

1000 xbar sums bitmexLivetrades`size