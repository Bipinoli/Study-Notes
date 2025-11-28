#!/bin/bash

iverilog -o a.out ./verilog/BidirectionalShiftRegister.BidirectionalShiftRegister.topEntity/topEntity.v ./verilog/BidirectionalShiftRegister.BidirectionalShiftRegister.testbench/testbench.v 
vvp a.out
