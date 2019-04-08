//
//  PhotoViewController.swift
//  Photo
//
//  Created by Đỗ Tấn Khoa on 4/6/19.
//  Copyright © 2019 Đỗ Tấn Khoa. All rights reserved.
//

import UIKit

class PhotoViewController: UICollectionViewController {
    
    var collectionData = ["1 🎃", "2 🚚", "3 🏍", "4 🏘", "5 ⚾️", "1 🎃", "2 🚚", "3 🏍", "4 🏘", "5 ⚾️", "1 🎃", "2 🚚", "3 🏍", "4 🏘", "5 ⚾️", "1 🎃", "2 🚚", "3 🏍", "4 🏘", "5 ⚾️", "1 🎃", "2 🚚", "3 🏍", "4 🏘", "5 ⚾️", "1 🎃", "2 🚚", "3 🏍", "4 🏘", "5 ⚾️", "1 🎃", "2 🚚", "3 🏍", "4 🏘", "5 ⚾️", "1 🎃", "2 🚚", "3 🏍", "4 🏘", "5 ⚾️"]
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Do any additional setup after loading the view.
        let width = (view.frame.size.width - 20) / 3
        let layout = collectionView.collectionViewLayout as!
        UICollectionViewFlowLayout
        layout.itemSize = CGSize(width: width, height: width)
    }
    
    
    /*
     // MARK: - Navigation
     
     // In a storyboard-based application, you will often want to do a little preparation before navigation
     override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
     // Get the new view controller using segue.destination.
     // Pass the selected object to the new view controller.
     }
     */
    
}


extension PhotoViewController {
    override func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return collectionData.count
    }
    
    override func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "ImageCell", for: indexPath)
        if let imageView = cell.viewWithTag(10) as? UIImageView {
            let url = URL(string: "https://salt.tikicdn.com/cache/w1200/ts/product/ad/6c/a9/fd6450656e968244cf43cabf55a3cbb0.jpg")
            imageView.load(url: url!)
        }
        return cell
    }
    
    override func scrollViewDidScroll(_ scrollView: UIScrollView) {
        if scrollView.contentOffset.y >= scrollView.contentSize.height - view.frame.size.height {
            print(scrollView.contentOffset.y)
            print(scrollView.contentSize.height)
            print(view.frame.size.height)
        }
    }
}

extension UIImageView {
    func load(url: URL) {
        DispatchQueue.global().async { [weak self] in
            if let data = try? Data(contentsOf: url) {
                if let image = UIImage(data: data) {
                    DispatchQueue.main.async {
                        self?.image = image
                    }
                }
            }
        }
    }
}
