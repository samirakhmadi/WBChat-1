import Foundation

public enum BankError: Error, CustomStringConvertible {
    case insufficientFunds(accountId: Int, currentBalance: Double, requestedAmount: Double)
    case idNotFound(accountId: Int)

    public var description: String {
        switch self {
        case .insufficientFunds(let accountId, let currentBalance, let requestedAmount):
            return "Выполнение операции невозможно! Недостаточно средств на счете \(accountId): текущий баланс \(currentBalance)₽, запрошенная сумма \(requestedAmount)₽"
        case .idNotFound(let accountId):
            return "Аккаунт с ID \(accountId) не найден."
        }
    }
}


