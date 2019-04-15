//
//  TopAlignedCollectionViewFlowLayout.swift
//  Photo
//
//  Created by Đỗ Tấn Khoa on 4/15/19.
//  Copyright © 2019 Đỗ Tấn Khoa. All rights reserved.
//

import UIKit

class TopAlignedCollectionViewFlowLayout: UICollectionViewFlowLayout {
    
    override func layoutAttributesForElements(in rect: CGRect) -> [UICollectionViewLayoutAttributes]? {
        if let attrs = super.layoutAttributesForElements(in: rect) {
            var baseline: CGFloat = -2
            var sameLineElements = [UICollectionViewLayoutAttributes]()
            var lastLineElements = [UICollectionViewLayoutAttributes]()
            for element in attrs {
                if element.representedElementCategory == .cell {
                    let frame = element.frame
                    let centerY = frame.midY
                    if abs(centerY - baseline) > 1 {
                        baseline = centerY
                        if alignToTopForSameLineElements(sameLineElements: sameLineElements, lastLineElements: lastLineElements) {
                            lastLineElements = sameLineElements
                        }
                        sameLineElements.removeAll()
                    }
                    sameLineElements.append(element)
                }
            }
            alignToTopForSameLineElements(sameLineElements: sameLineElements, lastLineElements: lastLineElements) // align one more time for the last line
            return attrs
        }
        return nil
    }
    
    private func alignToTopForSameLineElements(sameLineElements: [UICollectionViewLayoutAttributes], lastLineElements: [UICollectionViewLayoutAttributes]) -> Bool {
        if sameLineElements.count < 1 { return false }
        let sorted = sameLineElements.sorted { (obj1: UICollectionViewLayoutAttributes, obj2: UICollectionViewLayoutAttributes) -> Bool in
            let height1 = obj1.frame.size.height
            let height2 = obj2.frame.size.height
            let delta = height1 - height2
            return delta <= 0
        }
        if let tallest = sorted.last {
            if !lastLineElements.isEmpty && lastLineElements.count >= sameLineElements.count {
                for (index, obj) in sameLineElements.enumerated() {
                    let lastLineHeight = lastLineElements[index].frame.size.height
                    let lastLineIndex = lastLineElements[index].frame.origin.y
                    obj.frame = obj.frame.offsetBy(dx: 0, dy: lastLineIndex - obj.frame.origin.y + lastLineHeight + 10)
                }
            }
            else {
                for obj in sameLineElements {
                    obj.frame = obj.frame.offsetBy(dx: 0, dy: tallest.frame.origin.y - obj.frame.origin.y)
                }
            }
        }
        return true
    }
}
