import Foundation

public enum BankSuccess: CustomStringConvertible {
    case fundsWithdrawn(accountId: Int, currentBalance: Double)
    case fundsDeposited(accountId: Int, amount: Double)
    case fundsTransferred(senderId: Int, receiverId: Int, amount: Double)
    case interestAccrued(receiverId: Int, amount: Double)
    
    public var description: String {
        switch self {
        case .fundsWithdrawn(let accountId, let currentBalance):
            return "\nСнятие средств выполнено успешно. Счёт \(accountId), остаток: \(currentBalance)₽ "
        case .fundsDeposited(let accountId, let amount):
            return "\nВнесение средств выполнено успешно. Счёт \(accountId), сумма: \(amount)₽"
        case .fundsTransferred(let senderId, let receiverId,let amount):
            return "\nПеревод средств со счета \(senderId) на счет \(receiverId) на сумму \(amount)₽ выполнен успешно."
        case .interestAccrued(let receiverId, let amount):
            return "\nНачисление процентов по счету \(receiverId) в размере \(amount)₽"
        }
    }
}
