import Foundation
/*
 Цель: Научиться самому работать со структурами и классами на языке Swift.
 Задача:
 1. Создать объект класса Bank и добавить несколько счетов.
 2. Выполнить операции пополнения счета и перевода средств между счетами.
 3. Напечатать состояние всех счетов до и после выполнения операций.
 
 Дополнительно:
 1. Добавим возможность начисления процентов на счета.
 2. Реализуем систему типов счётов: обычный и сберегательный счёт.
 3. Сберегательные счета будут иметь фиксированную процентную ставку.
 4. Реализуем обработку ошибок при недостатке средств на счете.
 5. *Реализуем сущность транзакции для доступа к истории операций
 
 Результат: Консольная программа на Swift.
 */

import Foundation
import BankOnClasses_Sources

struct TransactionOperation {
    enum TransactionType {
        case deposit, transfer, withdraw, applyPercent
    }
    
    let id = UUID().uuidString
    let type: TransactionType
    let senderId: Int?
    let receiverId: Int?
    let amount: Double
    let transactionDate: Date = Date()
    
    init(type: TransactionType, senderId: Int? = nil, receiverId: Int? = nil, amount: Double) {
        self.type = type
        self.senderId = senderId
        self.receiverId = receiverId
        self.amount = amount
    }
}

final class BasicAccount: BasicAccountProtocol {
    let id: Int
    var balance: Double
    
    init(id: Int, balance: Double) {
        self.id = id
        self.balance = balance
    }
    
    func deposit(amount: Double) {
        balance += amount
    }
    
    func withdraw(amount: Double) -> Bool {
        if amount <= balance {
            balance -= amount
            return true
        } else {
            return false
        }
    }
}

final class SavingsAccount: SavingsAccountProtocol {
    let id: Int
    var balance: Double
    let percentRate: Double
    
    init(id: Int, balance: Double, percentRate: Double) {
        self.id = id
        self.balance = balance
        self.percentRate = percentRate
    }
    
    func deposit(amount: Double) {
        balance += amount
    }
    
    func withdraw(amount: Double) -> Bool {
        if amount <= balance {
            balance -= amount
            return true
        } else {
            return false
        }
    }
    
    func applyPercent() {
        balance += balance * percentRate
    }
}

final class Bank: BankProtocol {
    
    private var accounts: [Int: BasicAccountProtocol] = [:]
    private var transactions: [TransactionOperation] = []
    
    func addAccount(account: BasicAccountProtocol) {
        accounts[account.id] = account
    }
    
    func deposit(to accountId: Int, amount: Double) {
        accounts[accountId]?.deposit(amount: amount)
        handleDeposit(to: accountId, amount: amount)
    }
    
    func transfer(from fromAccountId: Int, to toAccountId: Int, amount: Double) {
        if let fromAccount = accounts[fromAccountId], fromAccount.withdraw(amount: amount) {
            accounts[toAccountId]?.deposit(amount: amount)
            handleTransfer(senderId: fromAccountId, receiverId: toAccountId, amount: amount)
        }
    }
    
    func applyPercentToSavingsAccounts() {
        for account in accounts.values {
            if let savingsAccount = account as? SavingsAccountProtocol {
                applyPercent(to: savingsAccount)
            }
        }
    }
    
    func printAccounts() {
        for (id, account) in accounts {
            print("Счет \(id): баланс \(account.balance), тип: \(type(of: account))")
        }
    }
    
    func printTransactions() {
        for (idx, transaction) in transactions.enumerated() {
            print(getTransactionInfo(idx: idx, transaction: transaction))
        }
    }
    
    func withdraw(from accountId: Int, amount: Double) {
        guard let account = accounts[accountId] else {
            print(BankError.idNotFound(accountId: accountId))
            return
        }
        if account.withdraw(amount: amount) {
            handleWithdraw(from: accountId, currentBalance: account.balance, amount: amount)
        } else {
            print(BankError.insufficientFunds(accountId: accountId, currentBalance: account.balance, requestedAmount: amount))
        }
    }
}

private extension Bank {
    
    func getTransactionInfo(idx: Int, transaction: TransactionOperation) -> String {
        let transactionNumber = idx + 1
        let transactionType = transaction.type
        let sender = transaction.senderId.map(String.init) ?? "ОТСУТСТВУЕТ"
        let receiver = transaction.receiverId.map(String.init) ?? "ОТСУТСТВУЕТ"
        let amount = transaction.amount
        let date = transaction.transactionDate
        
        return """
               \nТранзакция №\(transactionNumber):
               ID: \(transaction.id)
               ТИП: \(transactionType),
               ОТПРАВИТЕЛЬ: \(sender),
               ПОЛУЧАТЕЛЬ: \(receiver),
               CУММА: \(amount)₽
               ДАТА: \(date)
               """
    }
    
    func applyPercent(to account: SavingsAccountProtocol) {
        let balanceBefore = account.balance
        account.applyPercent()
        let balanceAfter = account.balance
        let accruedInterest = balanceAfter - balanceBefore
        
        handleInterestAccrued(for: account.id, amount: accruedInterest)
    }
    
    func handleInterestAccrued(for accountId: Int, amount: Double) {
        print(BankSuccess.interestAccrued(receiverId: accountId, amount: amount))
        logTransaction(type: .applyPercent, receiverId: accountId, amount: amount)
    }
    
    func handleTransfer(senderId: Int, receiverId: Int, amount: Double) {
        print(BankSuccess.fundsTransferred(senderId: senderId, receiverId: receiverId, amount: amount))
        logTransaction(type: .transfer, senderId: senderId, receiverId: receiverId, amount: amount)
    }
    
    func handleDeposit(to accountId: Int, amount: Double) {
        print(BankSuccess.fundsDeposited(accountId: accountId, amount: amount))
        logTransaction(type: .deposit, receiverId: accountId, amount: amount)
    }
    
    func handleWithdraw(from accountId: Int, currentBalance: Double, amount: Double) {
        logTransaction(type: .withdraw, senderId: accountId,  amount: amount)
        print(BankSuccess.fundsWithdrawn(accountId: accountId, currentBalance: currentBalance))
    }
    
    func logTransaction(type: TransactionOperation.TransactionType, senderId: Int? = nil, receiverId: Int? = nil, amount: Double) {
        let transaction = TransactionOperation(type: type, senderId: senderId, receiverId: receiverId, amount: amount)
        transactions.append(transaction)
    }
    
}

let bank = Bank()
let firstBasicAccount = BasicAccount(id: 1, balance: 50000)
let secondBasicAccount = BasicAccount(id: 2, balance: 75000)
let savingsAccount = SavingsAccount(id: 3, balance: 100000, percentRate: 0.08)

bank.addAccount(account: firstBasicAccount)
bank.addAccount(account: secondBasicAccount)
bank.addAccount(account: savingsAccount)

print("Открытые в банке счета:")
bank.printAccounts()

bank.deposit(to: 1, amount: 3000)
print("Состояние счетов после внесения:")
bank.printAccounts()

bank.transfer(from: 1, to: 2, amount: 15000)
print("Состояние счетов после перевода:")
bank.printAccounts()

bank.applyPercentToSavingsAccounts()
print("\nСостояние счетов после начисления процентов:")
bank.printAccounts()


print("\nРезультат при снятии доступного числа денег:")
bank.withdraw(from: 2, amount: 90000)

print("\nРезультат при снятии большего числа денег, чем хранится на счете:")
bank.withdraw(from: 2, amount: 80000)

print("\nСовершенные банковские операции:")
bank.printTransactions()

