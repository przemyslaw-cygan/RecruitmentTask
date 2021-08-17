//
//  PointSectionModel.swift
//  WorksmileRecruitmentTask
//
//  Created by Przemysław Cygan on 17/08/2021.
//

import RxDataSources

enum PathPointSectionModel {
    case mapSection(items: [Item])
    case infoSection(items: [Item])
}

extension PathPointSectionModel: SectionModelType {
    typealias Item = PathPointSectionItemModel

    var items: [Item] {
        switch self {
        case .mapSection(let items),
             .infoSection(let items):
            return items
        }
    }

    init(original: PathPointSectionModel, items: [PathPointSectionItemModel]) {
        switch original {
        case .mapSection(_):
            self = .mapSection(items: items)
        case .infoSection(_):
            self = .infoSection(items: items)
        }
    }
}

enum PathPointSectionItemModel {
    case pathPointMapItem(pathPoint: PathPoint)
    case pathPointInfoItem(name: String, value: String)
}
