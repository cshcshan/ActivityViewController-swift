//
//  ViewController.swift
//  ActivityViewController-swift
//
//  Created by Han Chen on 4/6/2016.
//  Copyright © 2016年 Han Chen. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
  @IBOutlet weak var activity_BarButtonItem: UIBarButtonItem!
  @IBOutlet weak var screenshot_View: UIView!
  @IBOutlet weak var screenshot_ImageView: UIImageView!
  var activity_AlertController: UIAlertController!
  var screenshot_AlertController: UIAlertController!
  
  enum ACTIVITY_TYPE: Int {
    case NONE
    case ONLY_STRING
    case ONLY_URL
    case LOCAL_IMAGE
    case SCREENSHOT
  }
  
  enum SCREENSHOT_TYPE: Int {
    case NONE
    case FULL
    case ONLY_VIEW
    case ONLY_IMAGE
  }
  
  override func viewDidLoad() {
    super.viewDidLoad()
    // Do any additional setup after loading the view, typically from a nib.
    
    print("Model: \(UIDevice.currentDevice().model)")
    self.setupActivity_AlertController()
    self.setupScreenshot_AlertController()
  }

  override func didReceiveMemoryWarning() {
    super.didReceiveMemoryWarning()
    // Dispose of any resources that can be recreated.
  }
  
  func setupActivity_AlertController() {
    self.activity_AlertController = UIAlertController(title: "Activity", message: "Select a data type", preferredStyle: .ActionSheet)
    let onlyString_AlertAction = UIAlertAction(title: "Only String", style: .Default) { (action) in
      self.displayActivityViewController(.ONLY_STRING, screenshotType: .NONE)
    }
    let onlyUrl_AlertAction = UIAlertAction(title: "Only Url", style: .Default) { (action) in
      self.displayActivityViewController(.ONLY_URL, screenshotType: .NONE)
    }
    let localImage_AlertAction = UIAlertAction(title: "Local Image", style: .Default) { (action) in
      self.displayActivityViewController(.LOCAL_IMAGE, screenshotType: .NONE)
    }
    let screenshot_AlertAction = UIAlertAction(title: "Screenshot", style: .Default) { (action) in
      self.displayScreenshot_AlertController()
    }
    let cancel_AlertAction = UIAlertAction(title: "Cancel", style: .Cancel, handler: nil)
    self.activity_AlertController.addAction(onlyString_AlertAction)
    self.activity_AlertController.addAction(onlyUrl_AlertAction)
    self.activity_AlertController.addAction(localImage_AlertAction)
    self.activity_AlertController.addAction(screenshot_AlertAction)
    self.activity_AlertController.addAction(cancel_AlertAction)
  }
  
  func setupScreenshot_AlertController() {
    self.screenshot_AlertController = UIAlertController(title: "Screenshot", message: "Select a screenshot type.", preferredStyle: .Alert)
    let fullScreen_AlertAction = UIAlertAction(title: "Full Screen", style: .Default) { (action) in
      self.displayActivityViewController(.SCREENSHOT, screenshotType: .FULL)
    }
    let view_AlertAction = UIAlertAction(title: "Only View", style: .Default) { (action) in
      self.displayActivityViewController(.SCREENSHOT, screenshotType: .ONLY_VIEW)
    }
    let image_AlertAction = UIAlertAction(title: "Only Image", style: .Default) { (action) in
      self.displayActivityViewController(.SCREENSHOT, screenshotType: .ONLY_IMAGE)
    }
    let cancel_AlertAction = UIAlertAction(title: "Cancel", style: .Cancel, handler: nil)
    self.screenshot_AlertController.addAction(fullScreen_AlertAction)
    self.screenshot_AlertController.addAction(view_AlertAction)
    self.screenshot_AlertController.addAction(image_AlertAction)
    self.screenshot_AlertController.addAction(cancel_AlertAction)
  }

  @IBAction func actionBarButtonItemPressed(sender: UIBarButtonItem) {
    self.displayActivity_AlertController()
  }
  
  func displayActivity_AlertController() {
    if UIDevice.currentDevice().userInterfaceIdiom == .Pad {
      if let view: UIView = self.activity_BarButtonItem.valueForKey("view") as? UIView {
        let frame = view.frame
        self.activity_AlertController.popoverPresentationController?.sourceView = view
        self.activity_AlertController.popoverPresentationController?.sourceRect = CGRectMake(0, frame.size.height, 0, 0)
        self.activity_AlertController.popoverPresentationController?.permittedArrowDirections = .Up
        self.presentViewController(self.activity_AlertController, animated: true, completion: nil)
      }
    } else {
      self.presentViewController(activity_AlertController, animated: true, completion: nil)
    }
  }
  
  func displayScreenshot_AlertController() {
    if UIDevice.currentDevice().userInterfaceIdiom == .Pad {
      if let view: UIView = self.activity_BarButtonItem.valueForKey("view") as? UIView {
        let frame = view.frame
        self.screenshot_AlertController.popoverPresentationController?.sourceView = view
        self.screenshot_AlertController.popoverPresentationController?.sourceRect = CGRectMake(0, frame.size.height, 0, 0)
        self.screenshot_AlertController.popoverPresentationController?.permittedArrowDirections = .Up
        self.presentViewController(self.screenshot_AlertController, animated: true, completion: nil)
      }
    } else {
      self.presentViewController(screenshot_AlertController
        , animated: true, completion: nil)
    }
  }
  
  func displayActivityViewController(activityType: ACTIVITY_TYPE, screenshotType: SCREENSHOT_TYPE) {
    var activityItems: [AnyObject]?
    switch activityType {
    case .ONLY_URL:
      activityItems = self.activityOnlyUrl()
    case .LOCAL_IMAGE:
      activityItems = self.activityLocalImage()
    case .SCREENSHOT:
      activityItems = self.activityScreenshot(screenshotType)
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
  
  func activityScreenshot(type: SCREENSHOT_TYPE) -> [AnyObject] {
    var layer: CALayer!
    let scale = UIScreen.mainScreen().scale
    let opaque = false // 不透明
    
    switch type {
    case .FULL:
      layer = UIApplication.sharedApplication().keyWindow?.layer
    case .ONLY_VIEW:
      layer = self.screenshot_View.layer
    default:
      layer = self.screenshot_ImageView.layer
    }
    
    UIGraphicsBeginImageContextWithOptions((layer?.frame.size)!, opaque, scale)
    layer?.renderInContext(UIGraphicsGetCurrentContext()!)
    let image = UIGraphicsGetImageFromCurrentImageContext()
    UIGraphicsEndImageContext()
//    UIImageWriteToSavedPhotosAlbum(screenShot_Image, nil, nil, nil)
    return [image]
  }
}

