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
 4. Добавим функцию для начисления процентов на все сберегательные счета.
 5. Реализуем обработку ошибок при недостатке средств на счете.
 
 Результат: Консольная программа на Swift.
 */

import Foundation
import BankOnClasses_Sources

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
            print(BankError.insufficientFunds(accountId: id, currentBalance: balance, requestedAmount: amount).description)
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
            print(BankError.insufficientFunds(accountId: id, currentBalance: balance, requestedAmount: amount).description)
            return false
        }
    }
    
    func applyPercent() {
        balance += balance * percentRate
    }
}

final class Bank: BankProtocol {
    
    private var accounts: [Int: BasicAccountProtocol] = [:]
    
    func addAccount(account: BasicAccountProtocol) {
        accounts[account.id] = account
    }
    
    func deposit(to accountId: Int, amount: Double) {
        accounts[accountId]?.deposit(amount: amount)
    }
    
    func transfer(from fromAccountId: Int, to toAccountId: Int, amount: Double) {
        if let fromAccount = accounts[fromAccountId], fromAccount.withdraw(amount: amount) {
            accounts[toAccountId]?.deposit(amount: amount)
        }
    }
    
    func applyPercentToSavingsAccounts() {
        for account in accounts.values {
            if let interestBearingAccount = account as? SavingsAccountProtocol {
                interestBearingAccount.applyPercent()
            }
        }
    }
    
    func printAccounts() {
        for (id, account) in accounts {
            print("Счет \(id): баланс \(account.balance), тип: \(type(of: account))")
        }
    }
}

let bank = Bank()
let firstBasicAccount = BasicAccount(id: 1, balance: 1000)
let secondBasicAccount = BasicAccount(id: 2, balance: 1200)
let savingsAccount = SavingsAccount(id: 3, balance: 500, percentRate: 0.05)

bank.addAccount(account: firstBasicAccount)
bank.addAccount(account: secondBasicAccount)
bank.addAccount(account: savingsAccount)

print("Открытые в банке счета:")
bank.printAccounts()

bank.deposit(to: 1, amount: 200)
print("\nСостояние счетов после внесения:")
bank.printAccounts()

bank.transfer(from: 1, to: 2, amount: 300)
print("\nСостояние счетов после перевода:")
bank.printAccounts()

bank.applyPercentToSavingsAccounts()
print("\nСостояние счетов после начисления процентов:")
bank.printAccounts()

firstBasicAccount.withdraw(amount: 900)
print("\nСостояние счетов после съема денег:")
bank.printAccounts()

print("\nРезультат при снятии большего числа денег, чем хранится на счете:")
secondBasicAccount.withdraw(amount: 1650)

