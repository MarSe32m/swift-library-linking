#! /bin/bash
echo Statically linking Swift library to C executable isnt supported on macOS at the moment
echo Anyways see for yourself
# Build SwiftLibrary
swiftc -parse-as-library -emit-module -emit-library -static -module-name SwiftLibrary library.swift

# Build C executable
clang -I. -L. -lSwiftLibrary main.c -o main