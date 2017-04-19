//
//  DateManager.swift
//  Applikator
//
//  Created by Sergey Leskov on 4/13/17.
//  Copyright © 2017 Sergey Leskov. All rights reserved.
//

import Foundation

class DateManager {
    //==================================================
    // MARK: - Stored Properties
    //==================================================
    static let dateNil = Date(timeIntervalSince1970: 0)
    
    //dateToString
    static func dateToString(date: Date) -> String {
        return DateFormatter.localizedString(from: date, dateStyle: DateFormatter.Style.medium, timeStyle: DateFormatter.Style.none)
    }
    
    //dateAndTimeToString
    static func dateAndTimeToString(date: Date) -> String {
        return DateFormatter.localizedString(from: date, dateStyle: DateFormatter.Style.short, timeStyle: DateFormatter.Style.short)
    }
    
    //datefromString
    static func datefromStringOfRss(string: String) -> Date {
        var date = Date()
        
        let dateFormatter = DateFormatter()
        //Tue, 11 Apr 2017 13:40:00 PDT
        //http://userguide.icu-project.org/formatparse/datetime
        
        dateFormatter.dateFormat = "EEE, dd MMM yyyy HH:mm:ss zzz"
        //print(string + " -> " + String(describing: dateFormatter.date(from: string)) )
        
        if let tempDate = dateFormatter.date(from: string) {
            date = tempDate
        }
        return date
    }
    
    //datefromString
    static func datefromString(string: String) -> Date {
        var date = Date()
        
        let dateFormatter = DateFormatter()
        //yyyy-MM-dd hh:mm:ss.SSSSxxx
        //http://userguide.icu-project.org/formatparse/datetime
        
        dateFormatter.dateFormat = "yyyy-MM-dd HH:mm:ss +zzzz"
        //print(string + " -> " + String(describing: dateFormatter.date(from: string)) )
        
        if let tempDate = dateFormatter.date(from: string) {
            date = tempDate
        }
        return date
    }

    
    
}
