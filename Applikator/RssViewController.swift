//
//  RssViewController.swift
//  Applikator
//
//  Created by Sergey Leskov on 4/13/17.
//  Copyright © 2017 Sergey Leskov. All rights reserved.
//

import UIKit
import CoreData

class RssViewController: UIViewController {
    
    //==================================================
    // MARK: - Stored Properties
    //==================================================
    
    @IBOutlet weak var tableView: UITableView!
    
    
    var parser = XMLParser()
    var rssRecord: RssRecord!
    var rssRecords: [RssRecord] = []
    var currentParsedElement = ""
    var isItem = false
    
    lazy var fetchResultController: NSFetchedResultsController<Rss> = {
        
        let fetchRequest: NSFetchRequest<Rss> = Rss.fetchRequest()
        
        let sortDescriptor1 = NSSortDescriptor(key: "dateSort", ascending: false)
        let sortDescriptor2 = NSSortDescriptor(key: "date", ascending: false)
        fetchRequest.sortDescriptors = [sortDescriptor1, sortDescriptor2]
        
        let fetchedResultsController = NSFetchedResultsController(fetchRequest: fetchRequest, managedObjectContext: CoreDataManager.shared.viewContext, sectionNameKeyPath: "dateSort", cacheName: nil)
        
        return fetchedResultsController
    }()
    
    
    //==================================================
    // MARK: - General
    //==================================================
    override func viewDidLoad() {
        super.viewDidLoad()
        
        
        
        tableView.delegate = self
        tableView.dataSource = self
        
        
        //fetchResultController
        fetchResultController.delegate = self
        do {
            try fetchResultController.performFetch()
        } catch {
            print(error)
        }
        
        //color
        tableView.backgroundColor = AppDataManager.backgroundColor
        view.backgroundColor = AppDataManager.backgroundColor
        
        //navigation
        navigationController?.navigationBar.barTintColor = AppDataManager.backgroundNavColor
        navigationController?.navigationBar.titleTextAttributes =
            [NSForegroundColorAttributeName: UIColor.white,
             NSFontAttributeName:UIFont.boldSystemFont(ofSize: 26)]
        
        
        loadData()
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    
    //==================================================
    // MARK: - load
    //==================================================
    func loadData() {
        //        if let rssURL = URL(string: urlRss) {
        //            UIApplication.shared.isNetworkActivityIndicatorVisible = true
        //            parser = XMLParser(contentsOf: rssURL)!
        //            parser.delegate = self
        //            parser.parse()
        //        }
        
        UIApplication.shared.isNetworkActivityIndicatorVisible = true
        
        NetworkManager.getDataFromURL(completion: { (data, error) in
            if let error = error {
                print("Error NetworkManager.getDataFromURL: \(error)")
                UIApplication.shared.isNetworkActivityIndicatorVisible = false
                return
            }
            
            self.parser = XMLParser(data: data!)
            self.parser.delegate = self
            self.parser.parse()
        })
    }
    
    //==================================================
    // MARK: - func
    //==================================================
    //showAlert
    func showAlert(title: String, message: String)  {
        let alertController = UIAlertController(title: title, message: message, preferredStyle: UIAlertControllerStyle.alert)
        alertController.addAction(UIAlertAction(title: "OK", style: UIAlertActionStyle.default, handler: nil))
        self.present(alertController, animated: true, completion: nil)
    }
    
    
    //saveToCoreDate
    func saveToCoreDate()  {
        
        let moc = CoreDataManager.shared.viewContext
        moc.performAndWait{
            
            for  element in self.rssRecords {
                
                if element.title == "" ||  element.link == ""  || element.pubDate == "" ||  element.description == "" {
                    return
                }
                
                if RssManager.getRssByLink(link: element.link) != nil {
                    return
                }
                
                guard  Rss(title: element.title, link: element.link, descript: element.description, pubDate: element.pubDate) != nil
                    else { return }
                
            }
            CoreDataManager.shared.saveContext()
        }
    }
    
    
    //==================================================
    // MARK: - Navigation
    //==================================================
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if (segue.identifier == "Detail") {
            let destinationController = segue.destination as! DetailViewController
            let indexPath = (self.tableView.indexPathForSelectedRow!)
            let rss = fetchResultController.object(at: indexPath )
            destinationController.link = rss.link
        }
    }
    
}


//==================================================
// MARK: - extension - NSFetchedResultsControllerDelegate
//==================================================
extension RssViewController: NSFetchedResultsControllerDelegate {
    func controllerDidChangeContent(_ controller: NSFetchedResultsController<NSFetchRequestResult>) {
        tableView?.reloadData()
    }
}


//==================================================
// MARK: - extension - XMLParserDelegate
//==================================================
extension RssViewController: XMLParserDelegate {
    
    //parserDidStartDocument
    func parserDidStartDocument(_ parser: XMLParser) {
        rssRecords = []
    }
    
    //didStartElement
    func parser(_ parser: XMLParser, didStartElement elementName: String, namespaceURI: String?, qualifiedName qName: String?, attributes attributeDict: [String : String]) {
        if elementName == "item" {
            rssRecord = RssRecord()
            isItem = true
        }
        
        currentParsedElement = elementName
    }
    
    //foundCharacters
    func parser(_ parser: XMLParser, foundCharacters string: String) {
        if isItem == false {
            return
        }
        
        if string == "\n" {
            return
        }
        
        switch currentParsedElement {
        case "title":
            rssRecord.title += string
        case "description":
            rssRecord.description += string
        case "link":
            rssRecord.link += string
        case "pubDate":
            rssRecord.pubDate += string
        default:
            return
        }
    }
    
    //didEndElement
    func parser(_ parser: XMLParser, didEndElement elementName: String, namespaceURI: String?, qualifiedName qName: String?) {
        if elementName == "item" {
            isItem = false
            rssRecords.append(rssRecord)
        }
    }
    
    func parserDidEndDocument(_ parser: XMLParser) {
        UIApplication.shared.isNetworkActivityIndicatorVisible = false
        saveToCoreDate()
    }
    
    func parser(_ parser: XMLParser, parseErrorOccurred parseError: Error) {
        UIApplication.shared.isNetworkActivityIndicatorVisible = false
        showAlert(title: "Error parsing", message: parseError as! String)
    }
}


//==================================================
// MARK: - extension - Table view
//==================================================
extension RssViewController: UITableViewDelegate, UITableViewDataSource {
    
    //func countSectionsFetch()
    func countSectionsFetch() -> Int {
        if let sections = fetchResultController.sections,
            sections.count > 0 {
            return sections.count
        }
        return 0
    }
    
    // numberOfSections
    func numberOfSections(in tableView: UITableView) -> Int {
        return countSectionsFetch()
    }
    
    //numberOfRowsInSection
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if let sections = fetchResultController.sections, sections.count > 0 {
            return sections[section].numberOfObjects
        } else {
            return 0
        }
    }
    
    // cellForRowAt
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "Cell", for: indexPath) as! RssViewCell
        let rss = fetchResultController.object(at: indexPath)
        
        cell.dateUI.text = rss.pubDate
        cell.titleUI.text = rss.title
        cell.textUI.text = rss.descript
        
        cell.accessoryView = UIImageView(image: UIImage(named: "accessory"))
        
        return cell
    }
    
    
    //titleForHeaderInSection
    func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        if let sections = fetchResultController.sections {
            let currentSection = sections[section]
            
            let tempDate = DateManager.datefromString(string: currentSection.name)
            
            let dateFormatter = DateFormatter()
            dateFormatter.dateFormat = "EEE, dd MMM"
            let nameSection = dateFormatter.string(from: tempDate)
            return nameSection
            
            //return currentSection.name
        }
        return nil
    }
    
    
    
    // willDisplayHeaderView
    func tableView(_ tableView: UITableView, willDisplayHeaderView view: UIView, forSection section: Int){
        view.tintColor = AppDataManager.colorGroup
        
        let header = view as! UITableViewHeaderFooterView
        header.textLabel?.font = UIFont.boldSystemFont(ofSize: 28)
        header.textLabel?.textColor = AppDataManager.sectionTextColor
    }
    
}

