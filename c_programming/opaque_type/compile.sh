#!/bin/bash

mkdir -p build
clang -g -fsanitize=address -Wall -Werror -std=c23 main.c opaque.c -o build/main
