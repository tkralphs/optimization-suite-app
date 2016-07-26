#!/bin/bash

echo $1 &> request.sol
#if [ $1 = "MPS" ]; then
#    /var/optimization-suite/bin/symphony -F request.mod -f request.par &> request.sol
#else
#    /var/optimization-suite/bin/symphony -F request.mod -D request.dat -f request.par &> request.sol
#fi
