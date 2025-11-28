#!/bin/bash

iverilog -o a.out ./verilog/FourBitCounter.topEntity/topEntity.v ./verilog/FourBitCounter.testbench/testbench.v 
vvp a.out
