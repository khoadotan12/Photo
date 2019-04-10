//
//  PhotoViewCell.swift
//  Photo
//
//  Created by Đỗ Tấn Khoa on 4/10/19.
//  Copyright © 2019 Đỗ Tấn Khoa. All rights reserved.
//

import UIKit

class PhotoViewCell: UICollectionViewCell {
    @IBOutlet weak var imageView: UIImageView!
    internal var aspectConstraint : NSLayoutConstraint? {
        didSet {
            if oldValue != nil {
                imageView.removeConstraint(oldValue!)
            }
            if aspectConstraint != nil {
                imageView.addConstraint(aspectConstraint!)
            }
        }
    }
    
    override func prepareForReuse() {
        super.prepareForReuse()
        aspectConstraint = nil
    }
    
    func setCustomImage(image : UIImage) {
        
        imageView.image = image
    }
}
