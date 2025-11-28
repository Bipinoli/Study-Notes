#!/bin/bash

iverilog -o a.out ./verilog/FirFilter.FirFilter.topEntity/topEntity.v ./verilog/FirFilter.FirFilter.testbench/testbench.v 
vvp a.out
