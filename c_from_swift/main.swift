import SwiftLibrary
import CLibrary

var string = "Hello"

string.withCString { 
    printName($0)
}

print("2 is prime:", isPrime(2))
print("Primes for 0..<10", getPrimes(for: [0, 1, 2, 3, 4, 5, 6, 7, 8, 9, 10]))