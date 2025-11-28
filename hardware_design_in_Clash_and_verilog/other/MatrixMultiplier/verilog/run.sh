#!/bin/bash

iverilog matrixMultiplier.v test.v && vvp a.out
