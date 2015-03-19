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
    var animator: UIDynamicAnimator?
    
    
    override func viewDidLoad() {
        super.viewDidLoad()

        self.view.backgroundColor = UIColor(white: 1.0, alpha: 0.95)
        
        self.imageView = UIImageView(frame: CGRectMake(0, -320, self.view.bounds.size.width, self.view.bounds.size.width))
        self.view.addSubview(self.imageView!)
     
        if let photoDictionary = self.photo { //just in case someone forgot to set the photo variable
            PhotoController.imageForPhoto(photoDictionary, size: "standard_resolution") { (image) -> Void in
                self.imageView!.image = image
            }
        }
        
        
        var tap = UITapGestureRecognizer(target: self, action: "close")
        self.view.addGestureRecognizer(tap)
    }
    
    override func viewDidAppear(animated: Bool) {
        super.viewDidAppear(animated)
        
        //set up the animation of the image
        self.animator = UIDynamicAnimator(referenceView: self.view)
        var snap = UISnapBehavior(item: self.imageView!, snapToPoint: self.view.center)
        self.animator?.addBehavior(snap)
    }
    
//    override func viewDidLayoutSubviews() {
//        super.viewDidLayoutSubviews()
//        
//        var size = self.view.bounds.size
//        var imageSize = CGSizeMake(size.width, size.width)
//        
//        self.imageView?.frame = CGRectMake(0, (size.height - imageSize.height) / 2, imageSize.width, imageSize.height)
//    }
    
    
    func close() {
        
        self.animator?.removeAllBehaviors()
        
        var snap = UISnapBehavior(item: self.imageView!, snapToPoint: CGPointMake(CGRectGetMidX(self.view.bounds), CGRectGetMaxY(self.view.bounds) + 180))
        self.animator?.addBehavior(snap)
        
        self.dismissViewControllerAnimated(true, completion: nil)
    }

}
