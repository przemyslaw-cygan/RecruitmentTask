//
//  PointSectionModel.swift
//  WorksmileRecruitmentTask
//
//  Created by Przemysław Cygan on 17/08/2021.
//

import RxDataSources

enum PathPointSectionModel {
    case mapSection(title: String, items: [Item])
    case infoSection(title: String, items: [Item])
}

extension PathPointSectionModel: SectionModelType {
    typealias Item = PathPointSectionItemModel

    var items: [Item] {
        switch self {
        case .mapSection(_, let items),
             .infoSection(_, let items):
            return items
        }
    }

    init(original: PathPointSectionModel, items: [PathPointSectionItemModel]) {
        switch original {
        case .mapSection(let title, _):
            self = .mapSection(title: title, items: items)
        case .infoSection(let title, _):
            self = .infoSection(title: title, items: items)
        }
    }
}

enum PathPointSectionItemModel {
    case pathPointMapItem(pathPoint: PathPoint)
    case pathPointInfoItem(name: String, value: String)
}
