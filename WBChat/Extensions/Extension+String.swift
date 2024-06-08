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
