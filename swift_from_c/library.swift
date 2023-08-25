@_cdecl("printFromSwift")
public func printInSwift(string: UnsafeMutablePointer<CChar>) {
    let string = String(cString: string)
    print("Printing in Swift: \(string)")
    Task.detached {
        print("Running a detached task sent from C!")
    }
}
