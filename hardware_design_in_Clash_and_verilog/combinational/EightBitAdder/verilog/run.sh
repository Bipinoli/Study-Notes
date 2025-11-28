#!/bin/bash

iverilog 8bitAdder.v test.v
vvp a.out
