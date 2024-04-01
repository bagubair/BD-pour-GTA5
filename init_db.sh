#!/usr/bin/bash

DATABASE="projet"

dropdb $DATABASE >> /dev/null
createdb $DATABASE >> /dev/null

for i in tables_BD/* ; do
  if [ -f "$i" ]; then
    echo "Running $i"
    psql -d $DATABASE -f "$i"
  fi
done

echo "Done"
