//
//  UISegmentedControl.swift
//  WorksmileRecruitmentTask
//
//  Created by Przemysław Cygan on 17/08/2021.
//

import UIKit

extension UISegmentedControl {
    func setItems(_ items: [String]) {
        removeAllSegments()
        items.enumerated().forEach {
            insertSegment(withTitle: $0.element, at: $0.offset, animated: false)
        }
    }
}
