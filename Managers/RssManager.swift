//
//  RssManager.swift
//  Applikator
//
//  Created by Sergey Leskov on 4/13/17.
//  Copyright © 2017 Sergey Leskov. All rights reserved.
//

import Foundation
import CoreData

class RssManager {
    
    //func getRssByLink
    static func getRssByLink(link: String) -> Rss? {
        
        if link.isEmpty { return nil }
        
        let request = NSFetchRequest<Rss>(entityName: Rss.type)
        let predicate = NSPredicate(format: "link == %@", link)
        request.predicate = predicate
        
        let resultsArray = (try? CoreDataManager.shared.viewContext.fetch(request))
        
        return resultsArray?.first ?? nil
    }

    
}
