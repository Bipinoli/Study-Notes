#!/bin/bash

mkdir -p build
clang -g -Wall -fsanitize=address -std=c23 container_of.c -o ./build/container_of
