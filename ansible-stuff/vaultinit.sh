#! /bin/bash

vault init -key-shares=1 -key-threshold=1 > init.log

cat init.log | grep Unseal | awk '{print $4}' > unseal.token
cat init.log | grep Root | awk '{print $4}' > root.token
