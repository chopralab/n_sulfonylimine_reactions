#!/usr/bin/env bash

for i in "$@"; do

    name=${i:0:-13}
    value=`grep Gibbs $i | awk '{print $7}'`

    echo "$name,gcorr,$value"

done

