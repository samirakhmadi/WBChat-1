import Foundation

public struct WorkItem {
    public let id: UUID
    public let data: Data
    public let countNumber: Int //Для наглядности
    
    public init(id: UUID, data: Data, countNumber: Int) {
        self.id = id
        self.data = data
        self.countNumber = countNumber
    }
}
