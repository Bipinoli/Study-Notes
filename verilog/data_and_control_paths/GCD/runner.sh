#!/bin/bash

iverilog -o main gcd_control_path.v gcd_data_path.v test_gcd.v

./main
