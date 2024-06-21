import Foundation

public protocol BasicAccountProtocol {
    var id: Int { get }
    var balance: Double { get set }
    
    func deposit(amount: Double)
    func withdraw(amount: Double) -> Bool
}
