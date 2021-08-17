//
//  PathFilterPredicate.swift
//  WorksmileRecruitmentTask
//
//  Created by Przemysław Cygan on 17/08/2021.
//

import Foundation

enum PathFilter {
    case raw
}

extension PathFilter {
    func apply(for path: Path) -> Path {
        switch self {
        case .raw:
            return path
        }
    }
}
