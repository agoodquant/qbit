# qbit
print some money :)


All codes are developed and owned by author agoodquant

To setup,
  1. Install https://github.com/agoodquant/qinfra for Q running environment.
  2. Install https://github.com/agoodquant/qr for logging/util/quant modules.
  3. Put qinfra and qr on the SAME directory with qbit. (no space. space not tested)
  4. Important: depending where your modules are located. You would need to edit the dependency files. (depends.txt in each module). Default is Q:/

To launch the HFT Loader/RDB/HDB/HDB writter infrastructure, do the following
  1. open up 4 Q processes: Loader (via q_ssl), RDB/HDB/HDB Writter (via q).
  2. assign the port for each one.
  3. execute codes in qbit.q with corresponding component.

Alternatively, the batch files have been setup for each componenent in the directory hft. Change the content of the batch files if neccessarily. Please execute the following in order: hdb, hdbwriter, rdb, and loader.

Obviously, execute .bat in windows and .sh in linux.

 logging
 ===========
 logging is done in async extending on log4q in qr module. Below is a screenshot using baretail in windows. In linux, tail -f obviously
![alt text](https://github.com/agoodquant/qbit/blob/master/log.jpg)
 
