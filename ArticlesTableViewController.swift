//
//  ArticlesTableViewController.swift
//  Klick
//
//  Created by Anthony McDonald on 20/04/2015.
//  Copyright (c) 2015 Anthony McDonald. All rights reserved.
//

import UIKit

class ArticlesTableViewController: UITableViewController, XMLParserDelegate {
    
    var xmlParser : XMLParser!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
    if let url = NSURL(string: "feed://feeds.bbci.co.uk/news/rss.xml") {
        xmlParser = XMLParser()
        xmlParser.delegate = self
        xmlParser.startParsingWithContentsOfURL(url)

        }
    }
    

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

     func parsingWasFinished() {
        self.tableView.reloadData()

    // MARK: - Table view data source
    }

    override func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        // #warning Potentially incomplete method implementation.
        // Return the number of sections.
        return 1
    }

    override func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete method implementation.
        // Return the number of rows in the section.
        return xmlParser.arrParsedData.count
    }

    
    override func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCellWithIdentifier("idCell", forIndexPath: indexPath) as UITableViewCell
        
        let currentDictionary = xmlParser.arrParsedData[indexPath.row] as Dictionary<String, String>
        
        cell.textLabel?.text = currentDictionary["title"]
        
        return cell
    }
        
    
    
    override func tableView(tableView: UITableView, heightForRowAtIndexPath indexPath: NSIndexPath) -> CGFloat {
        return 80
    }
    
    
    override func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
        let dictionary = xmlParser.arrParsedData[indexPath.row] as Dictionary<String, String>
        let categoryLink = dictionary["link"]
        
        let categoryViewController = UIStoryboard(name: "Main", bundle: nil).instantiateViewControllerWithIdentifier("idCategoryViewController") as CategoryViewController
        
        categoryViewController.categoryURL = NSURL(string: categoryLink!)
        
        showDetailViewController(CategoryViewController(), sender: self)
        
    }

}


