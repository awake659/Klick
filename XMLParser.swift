//
//  XMLParser.swift
//  Klick
//
//  Created by Anthony McDonald on 20/04/2015.
//  Copyright (c) 2015 Anthony McDonald. All rights reserved.
//

@objc protocol XMLParserDelegate{
    func parsingWasFinished()
}

import UIKit

class XMLParser: NSObject, NSXMLParserDelegate {
   
    var arrParsedData = [Dictionary<String, String>]()

    var currentDataDictionary = Dictionary<String, String>()

    var currentElement = ""

    var foundCharacters = ""

    var delegate : XMLParserDelegate?

    func startParsingWithContentsOfURL(rssURL: NSURL) {
    if let parser = NSXMLParser(contentsOfURL: rssURL) {
        parser.delegate = self
        parser.parse()
        }

    }
    
    func parserDidEndDocument(parser: NSXMLParser) {
        delegate?.parsingWasFinished()
    }
    
    func parser(parser: NSXMLParser, didStartElement elementName: String!, namespaceURI: String!, qualifiedName qName: String!, attributes attributeDict: [NSObject : AnyObject]) {
        
        currentElement = elementName
    }
    
    func parser(parser: NSXMLParser, foundCharacters string: String!) {
        if (currentElement == "title" && currentElement != "BBC") || currentElement == "link" {
            foundCharacters += string
        }
    }
    func parser(parser: NSXMLParser, didEndElement elementName: String!, namespaceURI: String!, qualifiedName qName: String!) {
        if !foundCharacters.isEmpty {
            
            if elementName == "link"{
                foundCharacters = (foundCharacters as NSString).substringFromIndex(3)
            }
            
            currentDataDictionary[currentElement] = foundCharacters
            
            foundCharacters = ""
        
            }
        }
    
    func parser(parser: NSXMLParser, parseErrorOccurred parseError: NSError!) {
        println(parseError.description)
    }
    
    
    func parser(parser: NSXMLParser, validationErrorOccurred validationError: NSError!) {
        println(validationError.description)
    }
}


