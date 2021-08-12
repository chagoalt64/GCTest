//
//  Date+extensions.swift
//  GCTest
//
//  Created by Santiago Borjon on 11/08/21.
//

import Foundation

extension Date {

    static func - (recent: Date, previous: Date) -> (month: Int?, day: Int?, hour: Int?, minute: Int?, second: Int?) {
        let day = Calendar.current.dateComponents([.day], from: previous, to: recent).day
        let month = Calendar.current.dateComponents([.month], from: previous, to: recent).month
        let hour = Calendar.current.dateComponents([.hour], from: previous, to: recent).hour
        let minute = Calendar.current.dateComponents([.minute], from: previous, to: recent).minute
        let second = Calendar.current.dateComponents([.second], from: previous, to: recent).second

        return (month: month, day: day, hour: hour, minute: minute, second: second)
    }
    
    func getComponents() -> DateComponents{
        let calendar = Calendar.current
        let components = calendar.dateComponents([.day,.hour,.minute,.second], from: self)
        return components
    }
    
    func toString() -> String {
        let dateFormatter = DateFormatter()
        dateFormatter.timeZone = Calendar.current.timeZone
        dateFormatter.dateFormat = "yyyy-MM-dd HH:mm:ss"
        
        return dateFormatter.string(from: self)
    }
    
    static func fromString(_ string: String) -> Date {
        let dateFormatter = DateFormatter()
        dateFormatter.timeZone = Calendar.current.timeZone
        dateFormatter.dateFormat = "yyyy-MM-dd HH:mm:ss"
        
        return dateFormatter.date(from: string) ?? Date()
    }
}
