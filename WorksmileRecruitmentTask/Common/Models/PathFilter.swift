//
//  PathFilterPredicate.swift
//  WorksmileRecruitmentTask
//
//  Created by Przemysław Cygan on 17/08/2021.
//

import Foundation

enum PathFilter: Equatable {
    case raw
    case distance(max: Double)
    case distanceAlt(max: Double)
}

extension PathFilter {
    func apply(for path: Path) -> Path {
        switch self {
        case .raw:
            return path
        case .distance(let max):
            return path.enumerated()
                .filter { index, point in
                    guard path.indices.contains(index - 1) else { return true }
                    return point.distance - path[index - 1].distance < max
                }
                .map { $0.element}
        case .distanceAlt(let max):
            return path.reduce([PathPoint]()) { points, current in
                current.distance - (points.last?.distance ?? 0) < max
                    ? points + [current]
                    : points
            }
        }
    }
}

extension PathFilter {
    var title: String {
        switch self {
        case .raw:
            return AppString.PathFilter.raw.rawValue.localized
        case .distance(let max):
            return String(format: AppString.PathFilter.distance.rawValue.localized, max)
        case .distanceAlt(let max):
            return String(format: AppString.PathFilter.distanceAlt.rawValue.localized, max)
        }
    }
}
