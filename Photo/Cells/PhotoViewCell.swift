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
    
    override func prepareForReuse() {
        super.prepareForReuse()
        imageView.image = nil
    }
    
    func setCustomImage(image : UIImage) {
        imageView.image = image
    }
}
