//
//  Rss+CoreDataProperties.swift
//  Applikator
//
//  Created by Sergey Leskov on 4/12/17.
//  Copyright © 2017 Sergey Leskov. All rights reserved.
//

import Foundation
import CoreData


extension Rss {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<Rss> {
        return NSFetchRequest<Rss>(entityName: "Rss")
    }

    @NSManaged public var title: String
    @NSManaged public var link: String
    @NSManaged public var descript: String
    @NSManaged public var pubDate: String
    
    
    @NSManaged public var dateSort: Date
    @NSManaged public var date: Date

}
