import Foundation

public protocol BankProtocol {
    func addAccount(account: BasicAccountProtocol)
    func deposit(to accountId: Int, amount: Double)
    func transfer(from fromAccountId: Int, to toAccountId: Int, amount: Double)
    func applyPercentToSavingsAccounts()
    func printAccounts()
    func printTransactions()
    func withdraw(from accountId: Int, amount: Double)
}
