//
//  PhotosViewController.swift
//  Photo Bombers
//
//  Created by Tim Walsh on 3/17/15.
//  Copyright (c) 2015 ClassicTim. All rights reserved.
//

import UIKit

let reuseIdentifier = "Cell"

class PhotosViewController: UICollectionViewController, UIViewControllerTransitioningDelegate {

    
    var accessToken: String = ""
    var photos: [AnyObject] = []
    
    required init(coder aDecoder: NSCoder) {
        
        super.init(coder: aDecoder)
    }
    
    override init() {
        var layout = UICollectionViewFlowLayout()
        
        super.init(collectionViewLayout: layout)
        
        //This has to be called AFTER super so we can get the view initialized
        layout.itemSize = CGSizeMake( (view.frame.width-2)/3, (view.frame.width-2)/3)
        layout.minimumInteritemSpacing = 1.0
        layout.minimumLineSpacing = 1.0
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Register cell classes
        self.collectionView!.registerClass(PhotoCell.self, forCellWithReuseIdentifier: "photo")
        
        self.title = "Photo Bombers"
        self.collectionView?.backgroundColor = UIColor.whiteColor()
        
        
        //update the use of userDefaults to use a cocoaPod called NSKeychain so the access token can be stored securely
        let userDefaults = NSUserDefaults.standardUserDefaults()
        
        if let tempToken = userDefaults.objectForKey("accessToken") as? String {
            self.accessToken = tempToken
        }
        //self.accessToken = userDefaults.objectForKey("accessToken") as String
        
        if (self.accessToken.isEmpty) {
            SimpleAuth.authorize("instagram", options: ["scope": ["likes"]],completion: { (responseObject: AnyObject!, error: NSError!) -> Void in
                //println("response \(responseObject)")
                
                if let responseDictionary = responseObject! as? Dictionary <String , AnyObject>
                {
                    self.accessToken = responseDictionary["credentials"]!["token"]! as String
                    
                    userDefaults.setObject(self.accessToken, forKey: "accessToken")
                    userDefaults.synchronize()
                    
                    self.refresh()//reload the view after we sign in
                }
            })
        } else {
            self.refresh()
        }
        
        // Uncomment the following line to preserve selection between presentations
        // self.clearsSelectionOnViewWillAppear = false

                // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        // Get the new view controller using [segue destinationViewController].
        // Pass the selected object to the new view controller.
    }
    */

    // MARK: UICollectionViewDataSource

    override func numberOfSectionsInCollectionView(collectionView: UICollectionView) -> Int {
        //#warning Incomplete method implementation -- Return the number of sections
        return 1
    }


    override func collectionView(collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        //#warning Incomplete method implementation -- Return the number of items in the section
        return self.photos.count
    }

    override func collectionView(collectionView: UICollectionView, cellForItemAtIndexPath indexPath: NSIndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCellWithReuseIdentifier("photo", forIndexPath: indexPath) as PhotoCell
    
        // Configure the cell
    
        cell.backgroundColor = UIColor.lightGrayColor()
        cell.setPhoto(self.photos[indexPath.row] as NSDictionary)
        //cell.photo = (self.photos[indexPath.row] as NSDictionary)
        return cell
    }

    // MARK: UICollectionViewDelegate
    
    override func collectionView(collectionView: UICollectionView, didSelectItemAtIndexPath indexPath: NSIndexPath) {
        var photo = self.photos[indexPath.row] as NSDictionary
        var viewController = DetailViewController()
        //set the viewController to use a custom transition.  Be sure to implement the UIViewControllerTransitioningDelegate protocol
        viewController.modalPresentationStyle = UIModalPresentationStyle.Custom
        viewController.transitioningDelegate = self //this is why we need to implement the UIViewControllerTransitioningDelegate protocol
        viewController.photo = photo
        
        self.presentViewController(viewController, animated: true, completion: nil)
    }
    
    //MARK: - helper methods
    
    func refresh() {
        var session = NSURLSession.sharedSession()
        var urlString: String = "https://api.instagram.com/v1/tags/wcw/media/recent?access_token=\(self.accessToken)"
        var url = NSURL(string: urlString)
        var request = NSURLRequest(URL: url!)
        
        var task: NSURLSessionDownloadTask = session.downloadTaskWithRequest(request, completionHandler: { (location: NSURL!, response: NSURLResponse!, error: NSError!) -> Void in
            
            var data = NSData(contentsOfURL: location)
            var responseDictionary: NSDictionary = NSJSONSerialization.JSONObjectWithData(data!, options: nil, error: nil) as NSDictionary
            
            //println("text: \(responseDictionary)")
            
            self.photos = responseDictionary.valueForKeyPath("data") as [AnyObject]
            
            dispatch_async(dispatch_get_main_queue(), { () -> Void in
                
                self.collectionView!.reloadData()
                
            })
            
        })
        task.resume()
    }
    
    //MARK: - UIViewControllerTransitioningDelegate
    
    func animationControllerForPresentedController(presented: UIViewController, presentingController presenting: UIViewController, sourceController source: UIViewController) -> UIViewControllerAnimatedTransitioning? {
        return PresentDetailTransition()
    }
    
    func animationControllerForDismissedController(dismissed: UIViewController) -> UIViewControllerAnimatedTransitioning? {
        return DismissDetailTransition()
    }

}
