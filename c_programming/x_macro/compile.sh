#!/bin/bash

mkdir -p build
clang -g -Wall -std=c23 -fsanitize=address x_macro.c -o build/x_macro
