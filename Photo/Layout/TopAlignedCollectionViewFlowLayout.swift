//
//  TopAlignedCollectionViewFlowLayout.swift
//  Photo
//
//  Created by Đỗ Tấn Khoa on 4/15/19.
//  Copyright © 2019 Đỗ Tấn Khoa. All rights reserved.
//

import UIKit

class TopAlignedCollectionViewFlowLayout: UICollectionViewFlowLayout {
    
//    override func layoutAttributesForItem(at path: IndexPath) -> UICollectionViewLayoutAttributes? {
//        if var element = super.layoutAttributesForItem(at: path) {
//            if (path.row >= 3) {
//                let lastPath = IndexPath(row: path.row - 3, section: path.section)
//                let lastLineElements = super.layoutAttributesForItem(at: lastPath)
//                let lastFrame = lastLineElements?.frame
//                element = element.copy() as! UICollectionViewLayoutAttributes
//                element.frame.origin.y = lastFrame!.origin.y + lastFrame!.size.height + 10
//            }
//            return element
//        }
//        return nil
//    }
//    override func layoutAttributesForItem(at indexPath: IndexPath) -> UICollectionViewLayoutAttributes? {
//        var atts = super.layoutAttributesForItem(at:indexPath)!
//        if indexPath.item == 0 {
//            return atts
//        }
//        if atts.frame.origin.x - 1 <= self.sectionInset.left {
//            return atts
//        }
//        let ipPv = IndexPath(item:indexPath.row-1, section:indexPath.section)
//        let fPv = self.layoutAttributesForItem(at:ipPv)!.frame
//        let rightPv = fPv.origin.y
//        atts = atts.copy() as! UICollectionViewLayoutAttributes
//        atts.frame.origin.y = rightPv
//        return atts
//    }
//
//    override func layoutAttributesForElements(in rect: CGRect) -> [UICollectionViewLayoutAttributes]? {
//        let arr = super.layoutAttributesForElements(in: rect)!
//        return arr.map {
//            atts in
//
//            var atts = atts
//            if atts.representedElementCategory == .cell {
//                let ip = atts.indexPath
//                atts = self.layoutAttributesForItem(at:ip)!
//            }
//            return atts
//        }
//    }
//    override func layoutAttributesForElements(in rect: CGRect) -> [UICollectionViewLayoutAttributes]? {
//        if let attrs = super.layoutAttributesForElements(in: rect) {
//            var baseline: CGFloat = -2
//            var sameLineElements = [UICollectionViewLayoutAttributes]()
//            var lastLineElements = [UICollectionViewLayoutAttributes]()
//            for (index, element) in attrs.enumerated() {
//                if element.representedElementCategory == .cell {
//                    let frame = element.frame
//                    let centerY = frame.midY
//                    if abs(centerY - baseline) > 1 {
//                        baseline = centerY
//                        if alignToTopForSameLineElements(sameLineElements: sameLineElements, lastLineElements: lastLineElements) {
//                            lastLineElements = sameLineElements
//                        }
//                        sameLineElements.removeAll()
//                    }
//                    sameLineElements.append(element)
//                }
//            }
//            alignToTopForSameLineElements(sameLineElements: sameLineElements, lastLineElements: lastLineElements) // align one more time for the last line
//            return attrs
//        }
//        return nil
//    }
    
//    private func alignToTopForSameLineElements(sameLineElements: [UICollectionViewLayoutAttributes], lastLineElements: [UICollectionViewLayoutAttributes]) -> Bool {
//        if sameLineElements.count < 1 { return false }
//        let sorted = sameLineElements.sorted { (obj1: UICollectionViewLayoutAttributes, obj2: UICollectionViewLayoutAttributes) -> Bool in
//            let height1 = obj1.frame.size.height
//            let height2 = obj2.frame.size.height
//            let delta = height1 - height2
//            return delta <= 0
//        }
//        if let tallest = sorted.last {
//            if !lastLineElements.isEmpty {
//                if  lastLineElements.count < sameLineElements.count {
//                    return true
//                } else {
//                    for (index, obj) in sameLineElements.enumerated() {
//                        let lastLineHeight = lastLineElements[index].frame.size.height
//                        let lastLineIndex = lastLineElements[index].frame.origin.y
//                        obj.frame = obj.frame.offsetBy(dx: 0, dy: lastLineIndex - obj.frame.origin.y + lastLineHeight + 10)
//                    }
//                }
//            }
//            else {
//                for obj in sameLineElements {
//                    obj.frame = obj.frame.offsetBy(dx: 0, dy: tallest.frame.origin.y - obj.frame.origin.y)
//                }
//            }
//        }
//        return true
//    }
}
