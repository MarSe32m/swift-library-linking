@ECHO OFF
:: Build SwiftLibrary
swiftc -parse-as-library -emit-module -emit-library -module-name SwiftLibrary mylib.swift mylib2.swift

:: Build CLibrary
clang -shared lib.c -o CLibrary.dll

:: Build executable
swiftc -I. -L. -lSwiftLibrary -lCLibrary main.swift