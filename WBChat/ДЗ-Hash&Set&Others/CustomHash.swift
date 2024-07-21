//
//  CustomHash.swift
//  WBChat
//
//  Created by Александр on 21.07.2024.
//

import Foundation
//Задание 2. Придумайте и реализуйте собственную простую хеш-функцию для строк.

func customHash(_ text: String) -> Int {
    // Начальное значение хеша. Выбран год рождения(простое число).
    var hash: Int64 = 1999
    
    // Перебираем каждый символ во входной строке
    for (index, char) in text.enumerated() {
        // Получаем ASCII-значение символа или 0, если его нельзя преобразовать
        let charValue = Int64(char.asciiValue ?? 0)
        
        // Вычисляем множитель, зависящий от позиции символа(отступ от позиции = дата рождения)
        let multiplier = Int64(index + 1902)
        
        // Обновляем хеш:
        // 1. Умножаем значение символа на множитель
        // 2. Добавляем результат к текущему хешу, используя переполняющее сложение (&+)
        // 3. Берем остаток от деления на Int64.max для предотвращения переполнения
        hash = (hash &+ charValue * multiplier) % Int64.max
    }
    
    // Преобразуем окончательный хеш обратно в Int
    // truncatingIfNeeded обрезает значение, если оно не помещается в Int
    return Int(truncatingIfNeeded: hash)
}

// Пример использования
let testString = "Хешируем Абобу"
let hashResult = customHash(testString)
func printCustomHashResult() {
    print("Хеш фразы \"\(testString)\": \(hashResult)") //Хеш фразы "Хешируем Абобу": 63119
}
