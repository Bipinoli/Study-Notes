#!/bin/bash

mkdir -p build
clang -Wall -g -fsanitize=address -std=c23 intrusive_linked_list.c -o build/intrusive_linked_list
