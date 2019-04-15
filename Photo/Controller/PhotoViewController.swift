//
//  PhotoViewController.swift
//  Photo
//
//  Created by Đỗ Tấn Khoa on 4/6/19.
//  Copyright © 2019 Đỗ Tấn Khoa. All rights reserved.
//
import UIKit

class PhotoViewController: UICollectionViewController {
    
    struct ImageInfo {
        var url: String
        var width: Int
        var height: Int
    }
    var collectionData = [ImageInfo]()
    let key = String("99538a231288cc67714859f6513e8556be7aa5016b60a516315e8041f09a717c")
    var page = 1
    var loading = false
    var totalPage = 0
    var query = String("")
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Do any additional setup after loading the view.
        
        let width = (view.frame.size.width - 20) / 3
        let layout = collectionView.collectionViewLayout as! UICollectionViewFlowLayout
        layout.itemSize = CGSize(width: width, height: width)
        layout.headerReferenceSize = CGSize(width: self.collectionView.bounds.size.width, height: 50)
        layout.sectionHeadersPinToVisibleBounds = true
        loadAPI(self.page)
    }
    
    func search(_ query: String) {
        collectionData.removeAll()
        self.page = 1
        self.query = query
        self.loading = true
        searchAPI(query)
        self.collectionView.reloadData()
    }
    
    func loadMore() {
        self.page += 1
        self.loading = true
        if (self.query.isEmpty) {
            loadAPI(self.page)
        }
        else {
            searchAPI(self.query)
        }
    }
    
    func searchAPI(_ query: String) {
        var components = URLComponents(string: "https://api.unsplash.com/search/photos")!
        components.queryItems = [
            URLQueryItem(name: "client_id", value: self.key),
            URLQueryItem(name: "query", value: query),
            URLQueryItem(name: "page", value: String(self.page)),
            URLQueryItem(name: "per_page", value: "30")
        ]
        let url = components.url!
        let session = URLSession.shared
        let client = HTTPClient(session: session)
        client.get(url: url, completionHandler: {
            (data, error) -> Void in
            if let error = error {
                NSLog("Error: \(error)")
                return
            }
            if let data = data {
                if let jsonResponse = try? JSONSerialization.jsonObject(with: data, options: .allowFragments) {
                    if let jsonDict = jsonResponse as? NSDictionary{
                        if let total = jsonDict.value(forKey: "total_pages") {
                            self.totalPage = total as! Int
                            if let resultArray = (jsonDict.value(forKey: "results") as? NSArray) {
                                for object in resultArray {
                                    let objectDict = object as? NSDictionary
                                    if let urls = objectDict!.value(forKey: "urls"), let width = objectDict!.value(forKey: "width"), let height = objectDict!.value(forKey: "height") {
                                        if let thumb = (urls as? NSDictionary)!.value(forKey: "thumb") {
                                            DispatchQueue.main.sync{
                                                self.collectionData.append(ImageInfo(url: thumb as! String, width: width as! Int, height: height as! Int))
                                                let indexPath = IndexPath(row: self.collectionData.count - 1, section: 0)
                                                self.collectionView.insertItems(at: [indexPath])
                                            }
                                        }
                                    }
                                }
                            }
                        }
                        self.loading = false
                    }
                }
            }
        })
    }
    
    func loadAPI(_ page: Int) {
        let url = URL(string: "https://api.unsplash.com/photos?client_id=\(self.key)&page=\(self.page)&per_page=30")
        let session = URLSession.shared
        let client = HTTPClient(session: session)
        client.get(url: url!, completionHandler: {
            (data, error) -> Void in
            if let error = error {
                NSLog("Error: \(error)")
                return
            }
            if let data = data {
                if let jsonResponse = try? JSONSerialization.jsonObject(with: data, options: .allowFragments) {
                    if let jsonArray = jsonResponse as? NSArray{
                        for object in jsonArray {
                            let objectDict = object as? NSDictionary
                            if let urls = objectDict!.value(forKey: "urls"), let width = objectDict!.value(forKey: "width"), let height = objectDict!.value(forKey: "height") {
                                if let thumb = (urls as? NSDictionary)!.value(forKey: "thumb") {
                                    DispatchQueue.main.sync{
                                    self.collectionView.performBatchUpdates({
                                        self.collectionData.append(ImageInfo(url: thumb as! String, width: width as! Int, height: height as! Int))
                                        let indexPath = IndexPath(row: self.collectionData.count - 1, section: 0)
                                        self.collectionView.insertItems(at: [indexPath])
                                    }, completion: nil)
                                    }
                                }
                            }
                        }
                        self.loading = false
                    }
                }
            }
        })
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


extension PhotoViewController: UICollectionViewDelegateFlowLayout {

    override func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return collectionData.count
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let width = (view.frame.size.width - 30) / 3
        let imageWidth = CGFloat(collectionData[indexPath.row].width)
        let imageHeight = CGFloat(collectionData[indexPath.row].height)
        return CGSize(width: width, height: imageHeight * width / imageWidth)
    }
    
    override func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "ImageCell", for: indexPath) as! PhotoViewCell
        if let imageView = cell.viewWithTag(10) as? UIImageView {
            let url = URL(string: collectionData[indexPath.row].url)
            imageView.load(url: url!, completion: {
                image in
                cell.setCustomImage(image: image)
            })
        }
        return cell
    }
    
    override func scrollViewDidScroll(_ scrollView: UIScrollView) {
        if scrollView.contentOffset.y >= scrollView.contentSize.height - view.frame.size.height {
            if !loading && self.collectionData.count > 0 {
                loadMore()
            }
        }
    }
    
}

extension PhotoViewController {
    override func collectionView(_ collectionView: UICollectionView, viewForSupplementaryElementOfKind kind: String, at indexPath: IndexPath) -> UICollectionReusableView {
        // 1
        switch kind {
        // 2
        case UICollectionView.elementKindSectionHeader:
            // 3
            guard let headerView = collectionView.dequeueReusableSupplementaryView(
                ofKind: kind,
                withReuseIdentifier: "PhotoHeaderView",
                for: indexPath) as? PhotoHeaderView
                else {
                    fatalError("Invalid view type")
            }
            return headerView
        default:
            // 4
            assert(false, "Invalid element type")
        }
    }
}

extension PhotoViewController: UISearchBarDelegate {
    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
        if(!(searchBar.text?.isEmpty)!){
            search(searchBar.text!)
        }
    }
    
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        if (searchText.count == 0) {
            collectionData.removeAll()
            collectionView.reloadData()
            self.query = ""
            self.page = 1
            self.loading = false
            self.totalPage = 0
            loadAPI(1)
        }
    }
}

extension UIImageView {
    func load(url: URL, completion: @escaping ((UIImage) -> Void)) {
        DispatchQueue.global().async {
            if let data = try? Data(contentsOf: url) {
                if let image = UIImage(data: data) {
                    DispatchQueue.main.async {
                        completion(image)
                    }
                }
            }
        }
    }
}
