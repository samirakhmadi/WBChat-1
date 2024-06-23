//
//  Extension+StringInterpolation.swift
//  WBChat
//
//  Created by Александр on 21.06.2024.
//

import Foundation
//MARK: - Число+Месяц+Год
extension String.StringInterpolation {
    mutating func appendInterpolation(spellOut value: Date, _ locale: Locale) {
        let formatter = NumberFormatter()
        formatter.numberStyle = .spellOut
        formatter.locale = locale
        
        let calendar = Calendar.current
        let components = calendar.dateComponents([.day, .month, .year], from: value)
        
        if let day = components.day, 
            let month = components.month,
            let year = components.year {
            let dayString = formatter.string(from: NSNumber(value: day)) ?? ""
            let yearString = formatter.string(from: NSNumber(value: year)) ?? ""
            
            let dateFormatter = DateFormatter()
            dateFormatter.locale = locale
            let monthString = dateFormatter.monthSymbols[month - 1]
            
            appendLiteral("\(dayString)+\(monthString)+\(yearString)")
        }
    }
}
//MARK: - Число месяц
extension String.StringInterpolation {
    mutating func appendInterpolation(spellOutDayMonth value: Date, _ locale: Locale) {
        let numberFormatter = NumberFormatter()
        numberFormatter.numberStyle = .spellOut
        numberFormatter.locale = locale

        let calendar = Calendar.current
        let components = calendar.dateComponents([.day, .month], from: value)
        
        if let day = components.day, let month = components.month {
            let dayString = numberFormatter.string(from: NSNumber(value: day)) ?? ""

            let dateFormatter = DateFormatter()
            dateFormatter.locale = locale
            let monthString = dateFormatter.monthSymbols[month - 1]

            appendLiteral("\(dayString) \(monthString)")
        }
    }
}
//MARK: - День недели, число месяц год
extension String.StringInterpolation {
    mutating func appendInterpolation(spellOutFullDate value: Date, _ locale: Locale) {
        let numberFormatter = NumberFormatter()
        numberFormatter.numberStyle = .spellOut
        numberFormatter.locale = locale

        let calendar = Calendar.current
        let components = calendar.dateComponents([.day, .month, .year, .weekday], from: value)
        
        if let day = components.day, let month = components.month, let year = components.year, let weekday = components.weekday {
            let dayString = numberFormatter.string(from: NSNumber(value: day)) ?? ""
            let yearString = numberFormatter.string(from: NSNumber(value: year)) ?? ""

            let dateFormatter = DateFormatter()
            dateFormatter.locale = locale
            let monthString = dateFormatter.monthSymbols[month - 1]
            let weekdayString = dateFormatter.weekdaySymbols[weekday - 1]

            appendLiteral("\(weekdayString), \(dayString) \(monthString) \(yearString)")
        }
    }
}

//MARK: - Только год
extension String.StringInterpolation {
    mutating func appendInterpolation(spellOutYear value: Date, _ locale: Locale) {
        let numberFormatter = NumberFormatter()
        numberFormatter.numberStyle = .spellOut
        numberFormatter.locale = locale

        let calendar = Calendar.current
        let components = calendar.dateComponents([.year], from: value)
        
        if let year = components.year {
            let yearString = numberFormatter.string(from: NSNumber(value: year)) ?? ""
            appendLiteral(yearString)
        }
    }
}

//MARK: - Число месяц год, часы:минуты
extension String.StringInterpolation {
    mutating func appendInterpolation(spellOutDateTime value: Date, _ locale: Locale) {
        let numberFormatter = NumberFormatter()
        numberFormatter.numberStyle = .spellOut
        numberFormatter.locale = locale

        let calendar = Calendar.current
        let components = calendar.dateComponents([.day, .month, .year, .hour, .minute], from: value)
        
        if let day = components.day, let month = components.month, let year = components.year, let hour = components.hour, let minute = components.minute {
            let dayString = numberFormatter.string(from: NSNumber(value: day)) ?? ""
            let yearString = numberFormatter.string(from: NSNumber(value: year)) ?? ""
            let hourString = numberFormatter.string(from: NSNumber(value: hour)) ?? ""
            let minuteString = numberFormatter.string(from: NSNumber(value: minute)) ?? ""

            let dateFormatter = DateFormatter()
            dateFormatter.locale = locale
            let monthString = dateFormatter.monthSymbols[month - 1]

            appendLiteral("\(dayString) \(monthString) \(yearString), \(hourString):\(minuteString)")
        }
    }
}


//MARK: - Header
extension String.StringInterpolation {
    mutating func appendInterpolation(if condition: @autoclosure () -> Bool, _ literal: StringLiteralType) {
        guard condition() else { return }
        appendLiteral(literal)
    }
}
