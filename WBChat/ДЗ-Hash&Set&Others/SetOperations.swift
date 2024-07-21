//
//  SetOperations.swift
//  WBChat
//
//  Created by Александр on 21.07.2024.
//

import Foundation
// Множества(Set) в Swift не сохраняют порядок элементов
// и содержат только уникальные значения.

// Задание 3. Set:
// Создайте множество (set) из целых чисел.
// Добавьте несколько элементов в это множество.
// Удалите один элемент.
// Проверьте, существует ли определенный элемент в множестве.
// Примените операции объединения, пересечения и разности на множествах

// Создаем пустое множество целых чисел
var mySet = Set<Int>()

// Добавляем несколько элементов в множество
func insertOperation() {
    mySet.insert(1)
    mySet.insert(2)
    mySet.insert(3)
    mySet.insert(4)
    mySet.insert(5)
    print("Исходное множество: \(mySet)") //Исходное множество: [2, 5, 3, 1, 4]
}
// Удаляем один элемент из множества
func removeOperation() {
    mySet.remove(3)
    print("Множество после удаления 3: \(mySet)") //Множество после удаления 3: [2, 5, 1, 4]
}

// Проверяем, существует ли конкретный элемент в множестве
func containsOperation() {
    let isContains = mySet.contains(4)
    print("Множество содержит 4: \(isContains)") //Множество содержит 4: true
    
}

// Выполняем операции над множествами
let setA: Set<Int> = [1, 2, 3, 4]
let setB: Set<Int> = [3, 4, 5, 6]

// Объединение: все элементы из обоих множеств
func unionOperation() {
    let unionSet = setA.union(setB)
    print("Объединение A и B: \(unionSet)") //Объединение A и B: [4, 2, 3, 5, 6, 1]
}

// Пересечение: элементы, которые есть в обоих множествах
func intersectOperation() {
    let intersectionSet = setA.intersection(setB)
    print("Пересечение A и B: \(intersectionSet)") //Пересечение A и B: [3, 4]
}

// Разность: элементы из A, которых нет в B
func differenceOperation() {
    let differenceSet = setA.subtracting(setB)
    print("Разность A и B: \(differenceSet)") //Разность A и B: [2, 1]
}
