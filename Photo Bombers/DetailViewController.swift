//
//  DetailViewController.swift
//  Photo Bombers
//
//  Created by Tim Walsh on 3/18/15.
//  Copyright (c) 2015 ClassicTim. All rights reserved.
//

import UIKit

class DetailViewController: UIViewController {

    var photo: NSDictionary?
    var imageView: UIImageView?
    
    
    override func viewDidLoad() {
        super.viewDidLoad()

        self.view.backgroundColor = UIColor(white: 1.0, alpha: 0.95)
        
        self.imageView = UIImageView()
        self.view.addSubview(self.imageView!)
     
        if let photoDictionary = self.photo { //just in case someone forgot to set the photo variable
            PhotoController.imageForPhoto(photoDictionary, size: "standard_resolution") { (image) -> Void in
                self.imageView!.image = image
            }
        }
        
        
        var tap = UITapGestureRecognizer(target: self, action: "close")
        self.view.addGestureRecognizer(tap)
    }
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        
        var size = self.view.bounds.size
        var imageSize = CGSizeMake(size.width, size.width)
        
        self.imageView?.frame = CGRectMake(0, (size.height - imageSize.height) / 2, imageSize.width, imageSize.height)
    }
    
    
    func close() {
        self.dismissViewControllerAnimated(true, completion: nil)
    }

}
