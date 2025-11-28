#!/bin/bash

iverilog -o a.out ./verilog/TrafficLight.TrafficLight.topEntity/topEntity.v ./verilog/TrafficLight.TrafficLight.testbench/testbench.v 
vvp a.out
