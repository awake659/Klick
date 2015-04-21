//
//  TopicsViewController.swift
//  Klick
//
//  Created by Anthony McDonald on 20/04/2015.
//  Copyright (c) 2015 Anthony McDonald. All rights reserved.
//

import UIKit

class CategoryViewController: UIViewController, UIPopoverPresentationControllerDelegate {
    
    var categoryURL : NSURL!
    
    var categoryButtonItem : UIBarButtonItem!
    
    var sharebutton: UIBarButtonItem!
    
    
    @IBOutlet weak var webview: UIWebView!
    
    @IBOutlet weak var toolbar: UIToolbar!
    
    @IBOutlet weak var shareButton: UIBarButtonItem!
    
    
    
    
    @IBAction func shareButton(sender: AnyObject){
        
        let firstActivityItem = ""
        
        let secondActivityItem : NSURL = NSURL(fileURLWithPath: "feed://feeds.bbci.co.uk/news/rss.xml")!
        
        let activityViewController : UIActivityViewController = UIActivityViewController(
            activityItems: [firstActivityItem, secondActivityItem], applicationActivities: nil)
        
        activityViewController.excludedActivityTypes = [
            UIActivityTypePostToWeibo,
            UIActivityTypePrint,
            UIActivityTypeAssignToContact,
            UIActivityTypeSaveToCameraRoll,
            UIActivityTypeAddToReadingList,
            UIActivityTypePostToTwitter,
            UIActivityTypePostToFacebook,
            UIActivityTypePostToTencentWeibo
        ]
        
        self.presentViewController(activityViewController, animated: true, completion: nil)
    }
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        webview.hidden = true
        toolbar.hidden = true
        
        categoryButtonItem = UIBarButtonItem(title: "Category", style: UIBarButtonItemStyle.Plain, target: self, action: "showCategoryViewController")
        
         NSNotificationCenter.defaultCenter().addObserver(self, selector: Selector("handleFirstViewControllerDisplayModeChangeWithNotification:"), name: "PrimaryVCDisplayModeChangeNotification", object: nil)

        // Do any additional setup after loading the view.
    }
    
    override func viewDidAppear(animated: Bool) {
        super.viewDidAppear(animated)
        
        if categoryURL != nil {
            let request : NSURLRequest = NSURLRequest(URL: categoryURL)
            webview.loadRequest(request)
            
            if webview.hidden {
                webview.hidden = false
                toolbar.hidden = false
            }
            if self.traitCollection.verticalSizeClass == UIUserInterfaceSizeClass.Compact{
                toolbar.items?.insert(self.splitViewController!.displayModeButtonItem(), atIndex: 0)
            }
            
        }
    }
    

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    deinit{
        NSNotificationCenter.defaultCenter().removeObserver(self)
    }
    
    func showCategoryViewController(){
        splitViewController?.preferredDisplayMode = UISplitViewControllerDisplayMode.AllVisible
    }
    
    func handleFirstViewControllerDisplayModeChangeWithNotification(notification: NSNotification){
        let displayModeObject = notification.object as? NSNumber
        let nextDisplayMode = displayModeObject?.integerValue
        
        if toolbar.items?.count == 3{
            toolbar.items?.removeAtIndex(0)
        }
        
        if nextDisplayMode == UISplitViewControllerDisplayMode.PrimaryHidden.rawValue {
            toolbar.items?.insert(categoryButtonItem, atIndex: 0)
        }
        else{
            toolbar.items?.insert(splitViewController!.displayModeButtonItem(), atIndex: 0)
        }

        func traitCollectionDidChange(previousTraitCollection: UITraitCollection) {
            if previousTraitCollection.verticalSizeClass == UIUserInterfaceSizeClass.Compact{
                let firstItem = toolbar.items?[0] as? UIBarButtonItem
                if firstItem?.title == "Category"{
                    toolbar.items?.removeAtIndex(0)
                }
            }
            else if previousTraitCollection.verticalSizeClass == UIUserInterfaceSizeClass.Regular{
                if toolbar.items?.count == 3{
                    toolbar.items?.removeAtIndex(0)
                }
                
                if splitViewController?.displayMode == UISplitViewControllerDisplayMode.PrimaryHidden {
                    toolbar.items?.insert(categoryButtonItem, atIndex: 0)
                }
                else{
                    toolbar.items?.insert(self.splitViewController!.displayModeButtonItem(), atIndex: 0)
                }
            }
        }

    
    }
}
