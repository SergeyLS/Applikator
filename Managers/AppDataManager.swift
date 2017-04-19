//
//  AppDataManager.swift
//  Applikator
//
//  Created by Sergey Leskov on 4/13/17.
//  Copyright © 2017 Sergey Leskov. All rights reserved.
//

import Foundation
import UIKit


class AppDataManager {
    
    //==================================================
    // MARK: - Singleton
    //==================================================
    static let shared = AppDataManager()
    private init() {
    }
    
    //==================================================
    // MARK: - colors
    //==================================================
    static let colorGroup = UIColor(red: 37.0/255, green: 77.0/255, blue: 148.0/255, alpha: 1.0)
    static let backgroundColor = UIColor(red: 210.0/255, green: 224.0/255, blue: 243.0/255, alpha: 1.0)
    
    static let backgroundNavColor = UIColor(red: 166.0/255, green: 195.0/255, blue: 232.0/255, alpha: 1.0)
    
    static let sectionTextColor = UIColor(red: 210.0/255, green: 224.0/255, blue: 243.0/255, alpha: 1.0)
    
    
}
