//
//  Date+Extensions.swift
//  Applikator
//
//  Created by Sergey Leskov on 4/13/17.
//  Copyright © 2017 Sergey Leskov. All rights reserved.
//

import Foundation

extension Date {

    //startOfDay
    var startOfDay: Date {
        return Calendar.current.startOfDay(for: self)
    }
    
}
