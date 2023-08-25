@ECHO OFF
:: Build SwiftLibrary
swiftc -parse-as-library -static -use-ld=lld-link -emit-module -emit-library -module-name SwiftLibrary mylib.swift mylib2.swift -o SwiftLibrary.lib

:: Build CLibrary
clang -static -fuse-ld=llvm-lib lib.c -o CLibrary.lib

:: Build executable
swiftc -I. -L. -lSwiftLibrary -lCLibrary main.swift