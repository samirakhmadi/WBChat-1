import Foundation

public struct Result {
    public let workItemId: UUID
    public let result: Data
    public let executionTime: TimeInterval
    
    public init(workItemId: UUID, result: Data, executionTime: TimeInterval) {
        self.workItemId = workItemId
        self.result = result
        self.executionTime = executionTime
    }
}
