#!/bin/bash

mkdir -p build
as exit.s -o build/exit.o
ld build/exit.o -o build/exit
