#!/bin/bash

iverilog -o mysim example.v example_test.v
vvp mysim
