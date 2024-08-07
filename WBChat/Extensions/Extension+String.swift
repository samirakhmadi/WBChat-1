//
//  Extension+String.swift
//  WBChat
//
//  Created by Александр on 08.06.2024.
//

import Foundation

extension String {
    /// Возвращает строку, содержащую первую букву первого слова и первую букву второго слова (если существует) из текущей строки.
    ///
    /// Если строка содержит только одно слово, возвращается первая буква этого слова.
    /// Если строка пуста, возвращается пустая строка.
    ///
    /// - Returns: Строка, содержащая первые буквы первых двух слов, или пустая строка, если слова отсутствуют.
    ///
    /// - Примеры:
    /// ```
    /// let name1 = "Абоба"
    /// print(name1.firstTwoInitials()) // Вывод: "А"
    ///
    /// let name2 = "Валерий Альбертович"
    /// print(name2.firstTwoInitials()) // Вывод: "ВА"
    ///
    /// let name3 = ""
    /// print(name3.firstTwoInitials()) // Вывод: ""
    /// ```
    ///
    /// - Note: Метод учитывает только первые два слова; остальные слова игнорируются. Если первая буква слова не является буквой, она игнорируется.
    func firstTwoInitials() -> String {
        // Разбиваем строку на слова
        let words = self.split(separator: " ")
        
        // Фильтруем слова
        let lettersOnlyWords = words.map { word -> String in
            // Убираем НЕбуквенные символы
            let filteredWord = word.filter { $0.isLetter }
            return String(filteredWord)
        }
        
        // Фильтрация пустых строк после удаления не-буквенных символов
        let nonEmptyWords = lettersOnlyWords.filter { !$0.isEmpty }
        
        // Если слова отсутствуют, возвращаем пустую строку
        if nonEmptyWords.isEmpty {
            return ""
        }
        
        // Получаем первую букву первого слова
        var initials = String(nonEmptyWords[0].prefix(1))
        
        // Если существует второе слово, добавляем его первую букву
        if nonEmptyWords.count > 1 {
            initials += String(nonEmptyWords[1].prefix(1))
        }
        
        return initials
    }
}

extension String {
    /// Форматирует строку, содержащую числовые данные, в соответствии с заданной маской.
    ///
    /// Метод удаляет все нецифровые символы из строки и применяет маску, вставляя цифры в соответствующие позиции.
    ///
    /// # Пример использования:
    /// ```
    /// let phoneNumber = "71234567890"
    /// let formattedNumber = phoneNumber.formatCustomNumber("+X XXX XXX-XX-XX") // "+7 123 456-78-90"
    /// ```
    /// - Parameter mask:
    /// Маска для форматирования, например, +X XXX XXX-XX-XX
    func formatCustomNumber(mask: String) -> String {
        let cleanNumber = components(separatedBy: CharacterSet.decimalDigits.inverted).joined()
            
        var result = ""
        var startIndex = cleanNumber.startIndex
        let endIndex = cleanNumber.endIndex
        
        for char in mask where startIndex < endIndex {
            if char == "X" {
                result.append(cleanNumber[startIndex])
                startIndex = cleanNumber.index(after: startIndex)
            } else {
                result.append(char)
            }
        }
        return result
    }
}

extension String {
    func countDigits() -> Int {
        let regex = /[0-9]/
        let matches = self.matches(of: regex)
        return matches.count
    }
}

extension String {
    /// Позволяет получить символ строки на заданной позиции.
    ///
    /// - Parameter idx: Индекс символа, который нужно получить.
    /// - Returns: Символ на позиции `idx`.
    ///
    /// # Пример использования:
    /// ```
    /// let text = "Hello"
    /// let character = text[1] // "e"
    /// ```
    subscript(_ idx: Int) -> Character {
        self[self.index(self.startIndex, offsetBy: idx)]
    }
}


extension String {
    func trimmedSurname() -> String {
        let words = self.split(separator: " ")
        guard words.count > 1 else {
            return self
        }
        
        if let firstWord = words.first, let secondWord = words.dropFirst().first {
            return "\(firstWord) \(secondWord.prefix(1))."
        }
        
        return self
    }
}
