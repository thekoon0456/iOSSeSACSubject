//
//  DateFormatter+.swift
//  SeSAC_TableAndCollectionView
//
//  Created by Deokhun KIM on 1/15/24.
//

import Foundation

enum DateStyle: String {
    case defaultStyle = "yyyy-MM-dd HH:mm"
    case dateChangeStyle = "yyyy년 M월 d일"
    case chatStyle = "yy.MM.dd"
    case chatRoomStyle = "HH:mm a"
}

class DateService {
    static let shared = DateService()
    
    private init() { }
    
    let formatter = DateFormatter()
    private var krLocale = Locale(identifier: "ko_kr")
    
    // MARK: - 최종적인 format결과
    
    func formattedDate(input: String, format: DateStyle.RawValue) -> String {
        let date = stringToDate(input)
        return dateToString(date, format: format)
    }
    
    func dateToString(_ date: Date?, format: DateStyle.RawValue) -> String {
        formatter.locale = krLocale
        formatter.dateFormat = format
        let result = formatter.string(from: date ?? Date())
        return result
    }
    
    private func stringToDate(_ stringDate: String, format: DateStyle.RawValue = DateStyle.defaultStyle.rawValue) -> Date? {
        formatter.locale = krLocale
        formatter.dateFormat = format
        let result = formatter.date(from: stringDate)
        return result
    }
    
//    func setLocale(_ locale: Locale = Locale(identifier: "ko_kr")) {
//        formatter.locale = locale
//    }
}

//extension String {
//    func stringToDate(_ stringDate: String, format: DateStyle.RawValue) -> Date? {
//        let dateService = DateService.shared
//        dateService.setLocale()
//        dateService.formatter.dateFormat = format
//        let result = dateService.formatter.date(from: stringDate)
//        return result
//    }
//}
//
//extension Date {
//    func dateToString(_ date: Date?, format: DateStyle.RawValue) -> String {
//        let dateService = DateService.shared
//        DateService.shared.setLocale()
//        dateService.formatter.dateFormat = format
//        let result = dateService.formatter.string(from: date ?? Date())
//        return result
//    }
//}
