import Foundation
import DistributionSystem_Sources

//Создайте распределенную систему обработки данных в которой:
//1. Несколько устройств могут совместно обрабатывать большие объемы данных в реальном времени.
//2. Поддерживать подключение нескольких клиентов.
//3. Асинхронно распределять задачи между клиентами.
//4. Синхронизировать результаты обработки между клиентами.
//5. Обеспечивать корректную обработку ошибок и восстановление после сбоев.

// MARK: Класс сервера
actor DistributedServer {
    private var clients: [DistributedClient] = []
    private var workItems: [WorkItem] = []
    private var results: [Result] = []
    
    func addClient(_ client: DistributedClient) {
        clients.append(client)
        print("📡 Сервер: Добавлен клиент: (\(client.name)). Всего: \(clients.count)")
    }
    
    func addWorkItem(_ workItem: WorkItem) {
        workItems.append(workItem)
        print("📦 Сервер: Добавлена новая задача (ID: \(workItem.id)). Присвоен номер \(workItem.countNumber). Всего задач: \(workItems.count)")
    }
    
    func startProcessing() {
        Task {
            while !workItems.isEmpty {
                await distributeWorkItem()
                try? await Task.sleep(nanoseconds: 500_000_000) // 0.5 секунды между распределением задач
            }
        }
    }
    
    func getClientStats() async -> [(name: String, completedTasks: Int, averageTime: TimeInterval)] {
        var stats: [(name: String, completedTasks: Int, averageTime: TimeInterval)] = []
        for client in clients {
            let count = await client.completedTasksCount
            let avgTime = await client.averageExecutionTime
            stats.append((name: client.name, completedTasks: count, averageTime: avgTime))
        }
        return stats
    }
    
    private func distributeWorkItem() async {
        guard let workItem = workItems.first else { return }
        
        for client in clients {
            if await !client.isBusy {
                let taskNumber = (workItems.count - workItems.count) + 1
                workItems.removeFirst()
                print("🔄 Сервер: Задачу №\(workItem.countNumber) с ID: \(workItem.id) выполняет \(client.name)")
                Task {
                    do {
                        let result = try await client.processWorkItem(workItem)
                        handleResult(result)
                    } catch {
                        print("❌ Сервер: Ошибка выполнения задачи ID: \(workItem.id) у клиента \(client.name): \(error)")
                        workItems.append(workItem)
                        print("🔙 Сервер: Задача ID: \(workItem.id) вернулась в очередь")
                    }
                }
                break
            }
        }
    }
    
    private func handleResult(_ result: Result) {
        results.append(result)
        print("✅ Сервер: Получен результат для задачи(ID: \(result.workItemId)). Время выполнения: \(String(format: "%.2f", result.executionTime)) сек. Выполнено задач: \(results.count)")
        Task { await syncResults() }
    }
    
    private func syncResults() async {
        print("🔄 Сервер: Синхронизация между всеми клиентами")
        for client in clients {
            await client.sync(results: results)
        }
    }
}

// MARK: Реализация клиента
class Client: DistributedClient {
    let name: String
    private let server: DistributedServer
    private var busy = false
    private var completedTasks = 0
    private var totalExecutionTime: TimeInterval = 0
    
    var isBusy: Bool {
        get async { busy }
    }
    
    var completedTasksCount: Int {
        get async { completedTasks }
    }
    
    var averageExecutionTime: TimeInterval {
        get async {
            guard completedTasks > 0 else { return 0 }
            return totalExecutionTime / Double(completedTasks)
        }
    }
    
    init(name: String, server: DistributedServer) {
        self.name = name
        self.server = server
    }
    
    func connect() async throws {
        await server.addClient(self)
        print("🟢 \(name): подключился")
    }
    
    func disconnect() async {
        print("🔴 \(name): отключился")
    }
    
    func processWorkItem(_ workItem: WorkItem) async throws -> Result {
        busy = true
        print("📱 \(name): Выполняю задачу \(workItem.countNumber)")
        let startTime = Date()
        // Симулируем время обработки от 1 до 4 секунд
        try await Task.sleep(nanoseconds: UInt64.random(in: 1_000_000_000...4_000_000_000))
        let executionTime = Date().timeIntervalSince(startTime)
        print("✅ \(name): Закончено выполнение задачи \(workItem.countNumber). Время выполнения: \(String(format: "%.2f", executionTime)) сек")
        busy = false
        completedTasks += 1
        totalExecutionTime += executionTime
        return Result(workItemId: workItem.id, result: Data(), executionTime: executionTime)
    }
    
    func sync(results: [Result]) async {
        print("🔄 \(name): синхронизирован. Выполнено \(results.count) задач")
    }
}

// MARK:  Пример использования

func runDistributedSystem(taskNumber: Int) async throws {
    print("\n📊 Запуск симуляции\n")
    
    let server = DistributedServer()
    
    let client1 = Client(name: "Клиент_№1", server: server)
    let client2 = Client(name: "Клиент_№2", server: server)
    let client3 = Client(name: "Клиент_№3", server: server)
    
    print("🚀 Подключение клиентов...")
    try await client1.connect()
    try await client2.connect()
    try await client3.connect()
    
    print("\n📦 Добавление задачи...")
    for i in 1...taskNumber {
        await server.addWorkItem(WorkItem(id: UUID(), data: Data(), countNumber: i))
    }
    
    print("\n⏳Выполнение задач...\n")
    await server.startProcessing()
    
    // Ждем завершения всех задач
    try await Task.sleep(nanoseconds: 15_000_000_000)

    print("\n📊 Статистика выполненных задач:")
    let stats = await server.getClientStats()
    for stat in stats {
        print("👤 \(stat.name): выполнено задач - \(stat.completedTasks), среднее время выполнения - \(String(format: "%.2f", stat.averageTime)) сек")
    }
    
    print("\n🏁 Завершение работы...")
    await client1.disconnect()
    await client2.disconnect()
    await client3.disconnect()
    print("\n⚙️⚒️ Симуляция системы прошла успешно\n")
}

// Запуск системы
Task {
    do {
        try await runDistributedSystem(taskNumber: 10)
    } catch {
        print("❌ Ошибка запуска: \(error)")
    }
}

