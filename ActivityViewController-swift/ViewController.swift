//
//  ViewController.swift
//  ActivityViewController-swift
//
//  Created by Han Chen on 4/6/2016.
//  Copyright © 2016年 Han Chen. All rights reserved.
//

import UIKit
// http://nshipster.com/uiactivityviewcontroller/

/*
 [UIActivityCategoryAction]
 UIActivityTypePrint
 UIActivityTypeCopyToPasteboard
 UIActivityTypeAssignToContact
 UIActivityTypeSaveToCameraRoll
 UIActivityTypeAddToReadingList
 UIActivityTypeAirDrop
 UIActivityCategoryShare
 
 [UIActivityTypeMessage]
 UIActivityTypeMail
 UIActivityTypePostToFacebook
 UIActivityTypePostToTwitter
 UIActivityTypePostToFlickr
 UIActivityTypePostToVimeo
 UIActivityTypePostToTencentWeibo
 UIActivityTypePostToWeibo
 */

class ViewController: UIViewController {
  @IBOutlet weak var activity_BarButtonItem: UIBarButtonItem!
  var alertController: UIAlertController!
  var activityDataType: Int = -1

  override func viewDidLoad() {
    super.viewDidLoad()
    // Do any additional setup after loading the view, typically from a nib.
    
    print("Model: \(UIDevice.currentDevice().model)")
    self.setupAlertController()
  }

  override func didReceiveMemoryWarning() {
    super.didReceiveMemoryWarning()
    // Dispose of any resources that can be recreated.
  }
  
  func setupAlertController() {
    self.alertController = UIAlertController(title: "Select a data type", message: "", preferredStyle: .ActionSheet)
    let onlyString_AlertAction = UIAlertAction(title: "Only String", style: .Default) { (action) in
      self.activityDataType = 0
      self.displayActivityViewController()
    }
    let onlyUrl_AlertAction = UIAlertAction(title: "Only Url", style: .Default) { (action) in
      self.activityDataType = 1
      self.displayActivityViewController()
    }
    let localImage_AlertAction = UIAlertAction(title: "Local Image", style: .Default) { (action) in
      self.activityDataType = 2
      self.displayActivityViewController()
    }
    let cancel_AlertAction = UIAlertAction(title: "Cancel", style: .Cancel, handler: nil)
    self.alertController.addAction(onlyString_AlertAction)
    self.alertController.addAction(onlyUrl_AlertAction)
    self.alertController.addAction(localImage_AlertAction)
    self.alertController.addAction(cancel_AlertAction)
  }

  @IBAction func actionBarButtonItemPressed(sender: UIBarButtonItem) {
    self.displayAlertController()
  }
  
  func displayAlertController() {
    if UIDevice.currentDevice().userInterfaceIdiom == .Pad {
      if let view: UIView = self.activity_BarButtonItem.valueForKey("view") as? UIView {
        let frame = view.frame
        self.alertController.popoverPresentationController?.sourceView = view
        self.alertController.popoverPresentationController?.sourceRect = CGRectMake(0, frame.size.height, 0, 0)
        self.alertController.popoverPresentationController?.permittedArrowDirections = .Up
        self.presentViewController(self.alertController, animated: true, completion: nil)
      }
    } else {
      self.presentViewController(alertController, animated: true, completion: nil)
    }
  }
  
  func displayActivityViewController() {
    var activityItems: [AnyObject]?
    switch self.activityDataType {
    case 1:
      activityItems = self.activityOnlyUrl()
    case 2:
      activityItems = self.activityLocalImage()
    default:
      activityItems = self.activityOnlyString()
    }
    if activityItems != nil {
      let excludedActivityTypes = [UIActivityTypePostToTwitter, UIActivityTypePostToFacebook,
                                   UIActivityTypePostToWeibo,
                                   UIActivityTypeMessage, UIActivityTypeMail,
                                   UIActivityTypePrint, UIActivityTypeCopyToPasteboard,
                                   UIActivityTypeAssignToContact, UIActivityTypeSaveToCameraRoll,
                                   UIActivityTypeAddToReadingList, UIActivityTypePostToFlickr,
                                   UIActivityTypePostToVimeo, UIActivityTypePostToTencentWeibo,
                                   UIActivityTypeAirDrop]
      let activityViewController = UIActivityViewController(activityItems: activityItems!, applicationActivities: nil)
      activityViewController.excludedActivityTypes = excludedActivityTypes
      
      if UIDevice.currentDevice().userInterfaceIdiom == .Pad {
        if let view: UIView = self.activity_BarButtonItem.valueForKey("view") as? UIView {
          let frame = view.frame
          activityViewController.popoverPresentationController?.sourceView = view
          activityViewController.popoverPresentationController?.sourceRect = CGRectMake(0, frame.size.height, 0, 0)
          activityViewController.popoverPresentationController?.permittedArrowDirections = .Up
          self.presentViewController(activityViewController, animated: true, completion: nil)
        }
      } else {
        self.presentViewController(activityViewController, animated: true, completion: nil)
      }
    }
  }
  
  func activityOnlyString() -> [AnyObject] {
    return ["Hey"]
  }

  func activityOnlyUrl() -> [AnyObject] {
    return [NSURL(string: "http://www.apple.com")!]
  }
  
  func activityLocalImage() -> [AnyObject] {
    return [UIImage(named: "img")!]
  }
}

