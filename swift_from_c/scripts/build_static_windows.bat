@ECHO OFF
ECHO Statically linking a Swift library to a C executable is unsupported on Windows at the moment
ECHO Anyway see for yourself
:: Build SwiftLibrary
swiftc -parse-as-library -static -use-ld=lld-link -emit-module -emit-library -module-name SwiftLibrary library.swift -o SwiftLibrary.lib

:: Build the C executable
clang -I. -L. -lSwiftLibrary main.c -o main.exe