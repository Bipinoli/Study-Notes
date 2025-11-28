#!/bin/bash

iverilog bidirectionalShiftRegister.v test.v
vvp a.out
