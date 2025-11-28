#!/bin/bash

iverilog 4bitCounter.v test.v
vvp a.out
