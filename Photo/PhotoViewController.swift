//
//  PhotoViewController.swift
//  Photo
//
//  Created by Đỗ Tấn Khoa on 4/6/19.
//  Copyright © 2019 Đỗ Tấn Khoa. All rights reserved.
//

import UIKit

class PhotoViewController: UICollectionViewController {
    
    var collectionData = [String]()
    let key = String("99538a231288cc67714859f6513e8556be7aa5016b60a516315e8041f09a717c")
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Do any additional setup after loading the view.
        let width = (view.frame.size.width - 20) / 3
        let layout = collectionView.collectionViewLayout as! UICollectionViewFlowLayout
        layout.itemSize = CGSize(width: width, height: width)
        loadAPI()
    }
    
    func loadAPI() {
        let url = URL(string: "https://api.unsplash.com/photos?client_id=" + key + "&page=1&per_page=30")
        let dataTask = URLSession.shared.dataTask(with: url!, completionHandler: {
            (data, response, error) -> Void in
            if let error = error {
                NSLog("Error: \(error)")
                return
            }
            if let data = data {
                if let jsonResponse = try? JSONSerialization.jsonObject(with: data, options: .allowFragments) {
                    if let jsonArray = jsonResponse as? NSArray{
                        for object in jsonArray {
                            if let urls = (object as? NSDictionary)!.value(forKey: "urls") {
                                if let thumb = (urls as? NSDictionary)!.value(forKey: "thumb") {
                                    self.collectionData.append((thumb as? String)!)
                                }
                            }
                        }
                        OperationQueue.main.addOperation({
                            self.collectionView.reloadData()
//                            self.collectionView.performBatchUpdates({
//                                let indexPath = IndexPath(row: self.collectionData.count - 1, section: 0)
//                                self.collectionView.insertItems(at: [indexPath])
//                            }, completion: nil)
                        })
                    }
                }
            }
        })
        dataTask.resume()
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
            let url = URL(string: collectionData[indexPath.row])
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
