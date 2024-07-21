//
//  ApplesHash.swift
//  WBChat
//
//  Created by Александр on 21.07.2024.
//

import Foundation
//Задание 1: Напишите функцию на Swift, которая принимает строку и
//возвращает её хеш, используя встроенную функцию hash().

// Функция, использующая встроенный метод хеширования Swift
func applesHash(_ text: String) -> Int {
    // Свойство 'hash' автоматически вычисляет хеш-значение для строки
    return text.hash
}

// Пример использования
let testPhrase = "Hello, world!"
let result = applesHash(testPhrase)

func printResult() {
    print("Хеш фразы \"\(testPhrase)\" : \(result)") // Хеш фразы "Hello, world!" : 3298719764604925334
}

