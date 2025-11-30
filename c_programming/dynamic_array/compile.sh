#!/bin/bash

mkdir -p build
clang -Wall -fsanitize=address -g vector.c -o build/vector
