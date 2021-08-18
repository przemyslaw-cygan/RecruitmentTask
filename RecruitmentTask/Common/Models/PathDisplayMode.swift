//
//  PathDisplayMode.swift
//  RecruitmentTask
//
//  Created by Przemysław Cygan on 17/08/2021.
//

import Foundation

enum PathDisplayMode: Equatable {
    case all
    case accepted
    case rejected
}

extension PathDisplayMode {
    var title: String {
        switch self {
        case .all:
            return AppString.PathDisplayMode.all.rawValue.localized
        case .accepted:
            return AppString.PathDisplayMode.accepted.rawValue.localized
        case .rejected:
            return AppString.PathDisplayMode.rejected.rawValue.localized
        }
    }
}
