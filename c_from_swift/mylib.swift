import Foundation

public func isPrime(_ number: Int) -> Bool {
    Thread.sleep(forTimeInterval: 1)
    if number <= 2 { return true }
    for i in 2..<number {
        if number % i == 0 { return false }
    }
    return true
}