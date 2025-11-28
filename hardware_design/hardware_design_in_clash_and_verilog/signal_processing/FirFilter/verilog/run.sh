#!/bin/bash

iverilog firFilter.v test.v && vvp a.out
