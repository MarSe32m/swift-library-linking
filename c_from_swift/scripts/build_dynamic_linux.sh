#! /bin/bash

# Build SwiftLibrary
swiftc -parse-as-library -emit-module -emit-library -module-name SwiftLibrary mylib.swift mylib2.swift

# Build CLibrary
clang -shared lib.c -o libCLibrary.so

# Copy files to lib
sudo cp libCLibrary.so libSwiftLibrary.so /usr/local/lib

# Build executable
swiftc -I. -L. -lSwiftLibrary -lCLibrary main.swift

# ldconfig
sudo ldconfig