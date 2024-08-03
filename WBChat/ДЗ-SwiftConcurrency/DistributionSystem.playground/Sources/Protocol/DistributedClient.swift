import Foundation

// MARK: Протокол клиента
public protocol DistributedClient {
    var name: String { get }
    var isBusy: Bool { get async }
    var completedTasksCount: Int { get async }
    var averageExecutionTime: TimeInterval { get async }
    func connect() async throws
    func disconnect() async
    func processWorkItem(_ workItem: WorkItem) async throws -> Result
    func sync(results: [Result]) async
}
