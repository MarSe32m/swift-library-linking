#! /bin/bash

# Build SwiftLibrary
swiftc -parse-as-library -emit-module -emit-library -module-name SwiftLibrary library.swift

# Copy files to lib
sudo cp libSwiftLibrary.so /usr/local/lib

# Build C executable
clang -I. -L. -lSwiftLibrary main.c -o main

# ldconfig
sudo ldconfig