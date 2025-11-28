#!/bin/bash

# I have intentially put the wrong value in testbench which mean the test must fail
iverilog -o a.out ./verilog/RingBuffer.topEntity/topEntity.v ./verilog/RingBuffer.testbench/testbench.v 
vvp a.out
