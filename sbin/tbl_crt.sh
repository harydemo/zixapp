#!/bin/bash

cd $ZIXAPP_HOME/sql/table;

db2 connect to $DB_NAME user $DB_USER using $DB_PASS;
for file in `ls *.sql`; do
    db2 -tvf $file;
done

