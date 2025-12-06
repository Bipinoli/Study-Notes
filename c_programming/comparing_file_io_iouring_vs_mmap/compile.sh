#!/bin/bash

mkdir -p build
clang -Wall -fsanitize=address -g -std=c23 main.c -o build/main
