#!/bin/bash

cd $ZIXAPP_HOME/sql/table;

db2 connect to zdb_dev user ypinst using ypinst;
for file in `ls *.sql`; do
    db2 -tvf $file;
done

