//
//  DateFormatterManager.swift
//  SeSAC_TodoProject
//
//  Created by Deokhun KIM on 2/15/24.
//

import Foundation

final class DateFormatterManager {
    
    enum DateStyle: String {
        case dateAndHour = "yyyy년 M월 d일 a h시"
        case date = "yyyy년 M월 d일"
    }
    
    static let shared = DateFormatterManager()
    
    private init() { }
    
    let formatter = DateFormatter()
    private var krLocale = Locale(identifier: "ko_kr")
    
    // MARK: - 최종적인 format결과
    
    func formattedDate(input: String, inputFormat: DateStyle, outputFormat: DateStyle) -> String? {
        let date = stringToDate(input, format: inputFormat)
        return dateToString(date, format: outputFormat)
    }
    
    func dateToString(_ date: Date?, format: DateStyle) -> String? {
        formatter.locale = krLocale
        formatter.dateFormat = format.rawValue
        if let date {
            let result = formatter.string(from: date)
            return result
        } else {
            return nil
        }
    }
    
    func stringToDate(_ stringDate: String, format: DateStyle) -> Date? {
        formatter.locale = krLocale
        formatter.dateFormat = format.rawValue
        let result = formatter.date(from: stringDate)
        return result
    }
}
