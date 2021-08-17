//
//  PathSectionModel.swift
//  WorksmileRecruitmentTask
//
//  Created by Przemysław Cygan on 17/08/2021.
//

import RxDataSources

enum PathSectionModel {
    case mapSection(title: String, items: [Item])
    case pointsSection(title: String, items: [Item])
}

extension PathSectionModel: SectionModelType {
    typealias Item = PathSectionItemModel

    var items: [Item] {
        switch self {
        case .mapSection(_, let items),
             .pointsSection(_, let items):
            return items
        }
    }

    init(original: PathSectionModel, items: [PathSectionItemModel]) {
        switch original {
        case .mapSection(let title, _):
            self = .mapSection(title: title, items: items)
        case .pointsSection(let title, _):
            self = .pointsSection(title: title, items: items)
        }
    }
}

enum PathSectionItemModel {
    case pathMapItem(path: Path)
    case pathPointItem(pathPoint: PathPoint)
}
