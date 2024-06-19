import Foundation
import WorkerAndPassport_Sources

/*
 Цель: На практике изучить работу с памятью. Смоделировать фабрику по производству строительных материалов.
 
 Задача:
 1. На практике изучить работу с памятью.
 2. Создать классы `Person` и `Passport` с необходимыми свойствами и методами.
 3. Инициализировать объекты этих классов и установить связи между ними.
 4. Освободить ресурсы и проверить корректность удаления объектов.
 
 Результат: Консольная программа на языке Swift.
 */

protocol Worker: AnyObject {
    var fullName: String { get }
    var age: Int { get }
    var passport: Passport? { get set }
}

protocol Document {
    var series: String { get }
    var number: String { get }
    var issueDate: Date { get }
    var owner: Worker? { get set }
}

protocol MachineProtocol {
    var type: String { get }
    var model: String { get }
    var machineOperator: FabricWorker? { get set }
}


final class FabricWorker: Worker {
    
    private(set) var fullName: String
    private(set) var age: Int
    
    var passport: Passport?
    var machine: MachineProtocol?
    
    init(fullName: String, age: Int) {
        self.fullName = fullName
        self.age = age
        print("Работник по имени \(fullName) инициализирован")
    }
    
    deinit {
        print("Работник \(fullName) деинициализирован")
    }
}

final class Passport: Document {
    
    private(set) var series: String
    private(set) var number: String
    private(set) var issueDate: Date
    
    weak var owner: Worker?
    
    init(series: String, number: String, issueDate: Date, owner: Worker) {
        self.series = series
        self.number = number
        self.issueDate = issueDate
        self.owner = owner
        print("Паспорт \(series) \(number) инициализирован")
    }
    
    func checkPassportStatus() {
        if let owner = owner {
            print("Паспорт \(series) \(number) принадлежит \(owner.fullName)")
        } else {
            print("Паспорт \(series) \(number) больше не имеет владельца")
        }
    }
    
    deinit {
        print("Паспорт серии \(series) деинициализирован")
    }
}

final class Sawmill: MachineProtocol {
    
    private(set) var type: String
    private(set) var model: String
    weak var machineOperator: FabricWorker?
    
    init(type: String, model: String) {
        self.type = type
        self.model = model
        print("Станок типа \(type) модели \(model) инициализирован")
    }
    
    func checkMachineStatus() {
        if let machineOperator = machineOperator {
            print("За станком типа \(type) модели \(model) стоит \(machineOperator.fullName)")
        } else {
            print("Станок типа \(type) модели \(model) не занят, смена закрыта")
        }
    }
    
    deinit {
        print("Станок типа \(type) модели \(model) деинициализирован")
    }
}

func testVariant1() {
    print("➡️Вариант №1⬅️ Присвоение nil:\n")
    
    var sampleWorker: FabricWorker? = FabricWorker(fullName: "Абоба", age: 25)
    var passport: Passport? = Passport(series: "1234", number: "5678910", issueDate: Date(), owner: sampleWorker!)
    var machine: Sawmill? = Sawmill(type: "Пилорама", model: "XYZ-123")
    
    sampleWorker?.passport = passport
    sampleWorker?.machine = machine
    machine?.machineOperator = sampleWorker
    
    passport?.checkPassportStatus()
    machine?.checkMachineStatus()
    print("\n=================================================\n")
    sampleWorker = nil
    passport?.checkPassportStatus()
    machine?.checkMachineStatus()
    
    machine = nil
    passport = nil
    
    print("➡️Тест завершен⬅️\n")
}

testVariant1()

func testVariant2() {
    print("➡️Вариант №2⬅️ Выход из области видимости функции:\n")
    
    let sampleWorker = FabricWorker(fullName: "Aboba", age: 25)
    let passport = Passport(series: "1234", number: "5678910", issueDate: Date.distantPast, owner: sampleWorker)
    let machine = Sawmill(type: "Пилорама", model: "XYZ-456")
    
    sampleWorker.passport = passport
    sampleWorker.machine = machine
    machine.machineOperator = sampleWorker
    
    passport.checkPassportStatus()
    machine.checkMachineStatus()
    
    print("\n➡️Тест завершен⬅️\n")
}

testVariant2()

