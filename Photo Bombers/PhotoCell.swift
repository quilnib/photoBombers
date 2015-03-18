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
    var photo: NSDictionary? {
        get {
            return nil
        }
        set {
            var photoUrlString = newValue!.valueForKeyPath("images.standard_resolution.url") as String
            var url = NSURL(string: photoUrlString)
            self.downloadPhotoWithURL(url!)
        }
    }
    
    
    override init(frame: CGRect) {
        super.init(frame: frame)

        
        self.imageView = UIImageView()
        self.imageView?.image = UIImage(named: "Treehouse")
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
        
        var photoUrlString = photoDictionary.valueForKeyPath("images.standard_resolution.url") as String
        var url = NSURL(string: photoUrlString)
        self.downloadPhotoWithURL(url!)
    }
    
    func downloadPhotoWithURL(url: NSURL) {
        let session = NSURLSession.sharedSession()
        let request = NSURLRequest(URL: url)
        var task = session.downloadTaskWithRequest(request, completionHandler: { (location: NSURL!, response: NSURLResponse!, error: NSError!) -> Void in
            
            var data = NSData(contentsOfURL: location)
            var image = UIImage(data: data!)
            
            dispatch_async(dispatch_get_main_queue(), { () -> Void in
                self.imageView!.image = image
            })
        })
        task.resume()
    }
    
}
