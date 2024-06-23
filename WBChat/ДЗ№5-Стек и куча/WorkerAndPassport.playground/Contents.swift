import Foundation

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

protocol Machine: AnyObject{
    var type: String { get }
    var model: String { get }
    var machineOperator: FabricWorker? { get set }
}

final class FabricWorker: Worker {
    
    private(set) var fullName: String
    private(set) var age: Int
    
    var passport: Passport?
    var machine: Machine?
    
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

final class Sawmill: Machine {
    
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

struct Beam {
    let length: Double
    let width: Double
    let height: Double
    let machine: Machine

    init(length: Double, width: Double, height: Double, machine: Machine) {
        self.length = length
        self.width = width
        self.height = height
        self.machine = machine
        print("Балка размерами \(length) x \(width) x \(height) создана работником \(machine.machineOperator?.fullName ?? "N/A") на \(machine.model)")
    }
}

final class Factory {
    var workers: [Worker] = []
    var machines: [Machine] = []
    private var beams: [Beam] = []
    
    func addWorker(worker: Worker) {
        workers.append(worker)
        print("Работник \(worker.fullName) добавлен на завод")
    }
    
    func addMachine(machine: Machine) {
        machines.append(machine)
        print("Станок модели \(machine.model) добавлен на завод")
    }
    
    func produceBeam(length: Double, width: Double, height: Double, machine: Machine){
        if machines.contains(where: { $0 === machine }) {
            let beam = Beam(length: length, width: width, height: height, machine: machine)
            beams.append(beam)
        } else {
            print("Ошибка: станок \(machine.model) не найден на заводе")
        }
    }
    
    init(){
        print("Адрес памяти Фабрики: \(Unmanaged.passUnretained(self).toOpaque())")
    }
    
    deinit {
        print("Фабрика с работниками в количестве: \(workers.count) чел. была деинициализирована")
    }
}


func testVariant1() {
    print("➡️Вариант №1⬅️ Присвоение nil:\n")
    
    var factory: Factory? = Factory()

    //Создаем 1 работника
    var sampleWorker: FabricWorker? = FabricWorker(fullName: "Абоба", age: 25)
    var passport: Passport? = Passport(series: "1234", number: "5678910", issueDate: Date(), owner: sampleWorker!)
    var machine: Sawmill? = Sawmill(type: "Пилорама", model: "XYZ-123")
    
    //Создаем 2 работника
    var sampleWorker2: FabricWorker? = FabricWorker(fullName: "Валерий Альбертович", age: 35)
    var passport2: Passport? = Passport(series: "1098", number: "7654321", issueDate: Date(), owner: sampleWorker2!)
    var machine2: Sawmill? = Sawmill(type: "Пилорама", model: "XYZ-456")
    
    //Указываем связи для 1 работника
    sampleWorker?.passport = passport
    sampleWorker?.machine = machine
    machine?.machineOperator = sampleWorker
    
    //Указываем связи для 2 работника
    sampleWorker2?.passport = passport2
    sampleWorker2?.machine = machine2
    machine2?.machineOperator = sampleWorker2
    
    print("\n")
    //Добавляем работников и станки на предприятие
    factory?.addWorker(worker: sampleWorker!)
    factory?.addMachine(machine: machine!)
    
    factory?.addWorker(worker: sampleWorker2!)
    factory?.addMachine(machine: machine2!)
    
    //Опционально: проверяем статус у паспорта и станка
    passport?.checkPassportStatus()
    machine?.checkMachineStatus()
    
    //Создаем планки
    factory?.produceBeam(length: 2, width: 3, height: 5, machine: machine!)
    factory?.produceBeam(length: 4, width: 1, height: 2, machine: machine2!)

    
    print("\n")
    
    sampleWorker = nil
    sampleWorker2 = nil
    machine = nil
    machine2 = nil
    passport2 = nil
    passport = nil
    factory = nil
    //Независимо от nil у объектов sampleWorker, machine и passport, они высвободятся только после factory, потому что фабрика "удерживает" их своей сильной ссылкой. Напр. адрес у sampleWorker внутри метода 0x000060000170df40, а в массиве фабрики 0x0000600001729020, они разные. Поэтому сначала уничтожатся сильные ссылки внутри фабрики(после уничтожения фабрики), а потом внутри метода
    print("➡️Тест завершен⬅️\n")
}

testVariant1()

func testVariant2() {
    print("➡️Вариант №2⬅️ Выход из области видимости функции:\n")
    
    let factory = Factory()
    let sampleWorker = FabricWorker(fullName: "Aboba", age: 25)
    let passport = Passport(series: "1234", number: "5678910", issueDate: Date.distantPast, owner: sampleWorker)
    let machine = Sawmill(type: "Пилорама", model: "XYZ-456")
    
    sampleWorker.passport = passport
    sampleWorker.machine = machine
    machine.machineOperator = sampleWorker
    
    factory.addWorker(worker: sampleWorker)
    factory.addMachine(machine: machine)
    
    passport.checkPassportStatus()
    machine.checkMachineStatus()
    
    factory.produceBeam(length: 2.5, width: 0.3, height: 0.1, machine: machine)
    
    print("\n➡️Тест завершен⬅️\n")
}

testVariant2()

