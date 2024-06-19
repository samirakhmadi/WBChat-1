import Foundation

public enum BankError: Error, CustomStringConvertible {
    case insufficientFunds(accountId: Int, currentBalance: Double, requestedAmount: Double)
    
    public var description: String {
        switch self {
        case .insufficientFunds(let accountId, let currentBalance, let requestedAmount):
            return "Выполнение операции невозможно! Недостаточно средств на счете \(accountId): текущий баланс \(currentBalance), запрошенная сумма \(requestedAmount)"
        }
    }
}
