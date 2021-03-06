//
//  DetailViewController.swift
//  Applikator
//
//  Created by Sergey Leskov on 4/14/17.
//  Copyright © 2017 Sergey Leskov. All rights reserved.
//

import UIKit

class DetailViewController: UIViewController {
    
    //==================================================
    // MARK: - Stored Properties
    //==================================================
    @IBOutlet weak var webView: UIWebView!
    @IBOutlet weak var spinner: UIActivityIndicatorView!
    
    var link: String!
    
    //==================================================
    // MARK: - General
    //==================================================
    override func viewDidLoad() {
        super.viewDidLoad()
       
        //navigationController?.navigationBar.topItem?.title = "Back"
        
        
        //color
        view.backgroundColor = AppDataManager.backgroundColor
        webView.backgroundColor = AppDataManager.backgroundColor
        
        webView.delegate = self
        if let url = URL(string: link) {
            let request = URLRequest(url: url)
            webView.loadRequest(request)
        }
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
}



//==================================================
// MARK: - extension - UIWebViewDelegate
//==================================================
extension DetailViewController: UIWebViewDelegate {
    
    func webViewDidStartLoad(_ webView: UIWebView) {
        spinner.startAnimating()
    }
    
    func webViewDidFinishLoad(_ webView: UIWebView) {
        spinner.stopAnimating()
    }
    
    func webView(_ webView: UIWebView, didFailLoadWithError error: Error) {
        spinner.stopAnimating()
    }
    
}





