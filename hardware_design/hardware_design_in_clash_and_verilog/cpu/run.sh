#!/bin/bash

echo "\n:l to load module. :r to reload. :verilog to generate HDL\n"

echo " To run CpuTest do"
echo " \t 1) :l CpuTest.hs"
echo " \t 2) main\n"

echo " To run ExecuteTest do"
echo " \t 1) :l ExecuteTest.hs"
echo " \t 2) main\n"

echo " To generate verilog cpu do"
echo " \t 1) :l Cpu.hs"
echo " \t 2) :verilog\n"

stack exec -- clashi
