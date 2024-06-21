import Foundation

public protocol SavingsAccountProtocol: BasicAccountProtocol {
    var percentRate: Double { get }
    
    func applyPercent()
}
