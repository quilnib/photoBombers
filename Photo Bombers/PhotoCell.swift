//
//  PhotoCell.swift
//  Photo Bombers
//
//  Created by Tim Walsh on 3/17/15.
//  Copyright (c) 2015 ClassicTim. All rights reserved.
//

import UIKit

class PhotoCell: UICollectionViewCell {
    
    var imageView: UIImageView?
    var photo: NSDictionary?
    
    
    override init(frame: CGRect) {
        super.init(frame: frame)

        
        var tap = UITapGestureRecognizer(target: self, action: "like")
        tap.numberOfTapsRequired = 2
        self.addGestureRecognizer(tap)
        
        self.imageView = UIImageView()
        self.contentView.addSubview(self.imageView!)
        
    }

    required init(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        
        self.imageView!.frame = self.contentView.bounds
    }
    
    func setPhoto(photoDictionary: NSDictionary) {
        
        self.photo = photoDictionary
        
        PhotoController.imageForPhoto(self.photo!, size: "thumbnail") { (image) -> Void in
            self.imageView!.image = image
        }
        
    }
    
    
    func like() {
        
        //send the "like" POST to instagram
        var session = NSURLSession.sharedSession()
        var accessToken = NSUserDefaults.standardUserDefaults().objectForKey("accessToken") as String
        var urlString  = "https://api.instagram.com/v1/media/" + (self.photo!["id"] as String) + "/likes?access_token=\(accessToken)"
        var url = NSURL(string: urlString)
        var request = NSMutableURLRequest(URL: url!)
        request.HTTPMethod = "POST"
        
        var task: NSURLSessionDataTask = session.dataTaskWithRequest(request, completionHandler: { (location: NSData!, response: NSURLResponse!, error: NSError!) -> Void in
            if (error != nil){
                //something went wrong
            } else {
                self.showLikeCompletion()
            }
        })
        task.resume()
    }
    
    func showLikeCompletion() {
        let networkIssueController = UIAlertController(title: "Liked!", message: nil , preferredStyle: .Alert)

        var rootViewController = UIApplication.sharedApplication().keyWindow?.rootViewController
        rootViewController!.presentViewController(networkIssueController, animated: true, completion: nil)// you have to display the alert after you create it
        
        
        //only display the alert for 1.0 seconds, then remove it from the view
        var delayInSeconds: Double = 1.0
        var delta = Double(delayInSeconds) * Double(NSEC_PER_SEC)
        var popTime: dispatch_time_t = dispatch_time(DISPATCH_TIME_NOW, Int64(delta))
        
        dispatch_after(popTime, dispatch_get_main_queue()) { () -> Void in
            rootViewController!.dismissViewControllerAnimated(true, completion: nil)
        }
    }
    
}
