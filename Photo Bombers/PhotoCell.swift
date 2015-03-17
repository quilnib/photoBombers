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
    
}
