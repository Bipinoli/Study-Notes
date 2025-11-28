#!/bin/bash

iverilog simpleLatch.v test.v
vvp a.out
