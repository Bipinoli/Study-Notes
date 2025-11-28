#!/bin/bash

iverilog -o main fulladder_behavioral.v test.v
vvp ./main
