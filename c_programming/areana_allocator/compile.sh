#!/bin/bash

mkdir -p build
clang -g -fsanitize=address -Wall arena.c -o build/arena
