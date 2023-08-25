# swift-library-linking
This repository contains documentation on building Swift libraries using only `swiftc`. There are examples presented in the repository. Below is some basic documentation.

Let's say we have a library consisting of files mylib.swift, mylib2.swift, lib.h and lib.c. We'll build these into a library and module both statically and dynamically.

# Dynamic library
To build a dynamic Swift library run the following command on macOS, Linux and Windows
```shell
swiftc -parse-as-library -emit-module -emit-library -module-name NAME_OF_SWIFT_MODULE mylib.swift mylib2.swift
```
To build a dynamic C Library run the following command on macOS (.dylib), Linux (.so) and Windows (.dll)
```shell
clang -shared lib.c -o NAME_OF_C_MODULE(.dll/.so/.dylib)
```
For C modules you need to create a modulemap file, for example ```module.modulemap```
```
module NAME_OF_C_MODULE {
    header "lib.h"
    export *
}
```
To use the libraries, you need to import them in the Swift file by 
```swift 
import NAME_OF_SWIFT_MODULE
import NAME_OF_C_MODULE
```
and compile the file with
```shell
swiftc -I. -L. -lNAME_OF_SWIFT_MODULE -lNAME_OF_C_MODULE main.swift
```
On Linux if you get an error "Cannot open shared object file: No such file or directory" when running the program, copy the dynamic libraries into /usr/local/lib and run `sudo ldconfig` and it should fix it.

# Static library
On Windows, at the moment, you have to specify the linker separately
```shell
swiftc -parse-as-library -use-ld=lld-link -emit-module -emit-library -static -module-name NAME_OF_SWIFT_MODULE mylib.swift mylib2.swift -o NAME_OF_SWIFT_MODULE.lib
```
```shell
clang -static -fuse-ld=llvm-lib lib.c -o NAME_OF_C_MODULE.lib
```
On Linux and macOS you have to explicity link the static library
```shell
swiftc -parse-as-library -emit-module -emit-library -static -module-name <NAME_OF_MODULE> mylib.swift mylib2.swift
```
```shell
clang -c -fPIC lib.c -o lib.o
ar r NAME_OF_C_MODULE.a lib.o
```
For C modules you need to create a modulemap file, for example 
```
module NAME_OF_C_MODULE {
    header "lib.h"
    export *
}
```

To use the libraries, you need to import them by 
```swift
import NAME_OF_SWIFT_MODULE
import NAME_OF_C_MODULE
```
and compile the file with
```shell
swiftc -I. -L. -lNAME_OF_SWIFT_MODULE -lNAME_OF_C_MODULE main.swift
```
also the methods need to be annotated by `__declspec(dllexport)`, so you could do something like
```c
#if _WIN32
#define SEBBU_LIB_EXPORT __declspec(dllexport)
#else
#define SEBBU_LIB_EXPORT __attribute__((visibility(default)))
#endif
```

# Calling Swift code from C
You can also use Swift functions marked as @_cdecl from C:
```shell
swiftc -parse-as-library -emit-library -emit-module -module-name NAME_OF_SWIFT_MODULE library.swift
```
Static Swift libraries used by C-code only work on Linux at the moment (i.e. flag -static works only on Linux). Then as per usual compile the C executable with
```shell
clang -I. -L. -lNAME_OF_MODULE main.c -o main.exe
```
On linux you can use 
```shell
readelf -a <file> | grep "Shared library"
```
(grep Shared is also enough) to find all the needed shared libraries of the executable.
