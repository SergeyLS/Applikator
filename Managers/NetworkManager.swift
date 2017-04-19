//
//  NetworkManager.swift
//  Applikator
//
//  Created by Sergey Leskov on 4/14/17.
//  Copyright © 2017 Sergey Leskov. All rights reserved.
//

import Foundation


class NetworkManager {
    
    
    static func getDataFromURL(completion: @escaping (_ data: Data?, _ error: Error?) -> Void) {
        
        let stringURL: String = "http://developer.apple.com/news/rss/news.rss"
        
        let url = URL(string: stringURL)!
        
        let request = URLRequest(url: url, cachePolicy: .reloadIgnoringLocalCacheData, timeoutInterval: 10)
        
        let session = URLSession(configuration: .default)
        let task: URLSessionDataTask = session.dataTask(with: request) { (data: Data?, response: URLResponse?, error: Error?) in
            if let data = data
            {
                completion(data, nil)
                
            } else {
                completion(nil, error)
            }
            
        }
        task.resume()
        
    }
    
}
