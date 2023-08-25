#! /bin/bash

# Build SwiftLibrary
swiftc -parse-as-library -emit-module -emit-library -static -module-name SwiftLibrary mylib.swift mylib2.swift

# Build C code
clang -c -fPIC lib.c -o lib.o

# Link into a static library
ar r libCLibrary.a lib.o

# Build executable
swiftc -I. -L. -lSwiftLibrary -lCLibrary main.swift