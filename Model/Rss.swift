//
//  Rss+CoreDataClass.swift
//  Applikator
//
//  Created by Sergey Leskov on 4/12/17.
//  Copyright © 2017 Sergey Leskov. All rights reserved.
//

import Foundation
import CoreData


public class Rss: NSManagedObject {

    //==================================================
    // MARK: - Stored Properties
    //==================================================
    static let type = "Rss"
    
    //==================================================
    // MARK: - Initializers
    //==================================================
    
    convenience init?(title: String, link:String, descript: String, pubDate: String){
        guard let tempEntity = NSEntityDescription.entity(forEntityName: Rss.type, in: CoreDataManager.shared.viewContext) else {
            fatalError("Could not initialize \(Rss.type)")
            return nil
        }
        self.init(entity: tempEntity, insertInto: CoreDataManager.shared.viewContext)
        
        //self
        self.title = title
        self.link = link
        self.descript = descript
        self.pubDate = pubDate
        
        let tempDate = DateManager.datefromStringOfRss(string: pubDate)
        
        self.date = tempDate
        self.dateSort = tempDate.startOfDay
        
        print("add new \(Rss.type): \(title)")
    }

}
