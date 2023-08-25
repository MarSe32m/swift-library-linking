public func getPrimes(for numbers: [Int]) -> [Bool] {
    numbers.map { print(2 * $0); return isPrime($0) }
}