#! /bin/bash

# Build SwiftLibrary
swiftc -parse-as-library -emit-module -emit-library -module-name SwiftLibrary library.swift

# Build C executable
clang -I. -L. -lSwiftLibrary main.c -o main