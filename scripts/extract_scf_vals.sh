#!/usr/bin/env bash

for i in "$@"; do
    name=${i:0:-9}
    value=`grep 'SCF Energy' $i | awk '{print $4}'`
    echo "$name,scf,$value"
done

