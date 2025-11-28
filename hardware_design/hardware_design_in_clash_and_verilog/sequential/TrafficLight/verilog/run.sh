#!/bin/bash

iverilog trafficLight.v test.v && vvp a.out
