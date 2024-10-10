#!/bin/bash

iverilog ringBuffer.v test.v
vvp a.out
