import Foundation

public protocol BasicAccountProtocol {
    var id: Int { get }
    var balance: Double { get set }
    
    func deposit(amount: Double)
    func withdraw(amount: Double) -> Bool
}

public protocol SavingsAccountProtocol: BasicAccountProtocol {
    var percentRate: Double { get }
    
    func applyPercent()
}

public protocol BankProtocol {
    func addAccount(account: BasicAccountProtocol)
    func deposit(to accountId: Int, amount: Double)
    func transfer(from fromAccountId: Int, to toAccountId: Int, amount: Double)
    func applyPercentToSavingsAccounts()
    func printAccounts()
}
