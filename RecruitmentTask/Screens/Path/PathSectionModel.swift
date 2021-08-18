//
//  PathSectionModel.swift
//  RecruitmentTask
//
//  Created by Przemysław Cygan on 17/08/2021.
//

import RxDataSources

enum PathSectionModel {
    case mapSection(items: [Item])
    case optionsSection(items: [Item])
    case pointsSection(items: [Item])
}

extension PathSectionModel: SectionModelType {
    typealias Item = PathSectionItemModel

    var items: [Item] {
        switch self {
        case .mapSection(let items),
             .optionsSection(let items),
             .pointsSection(let items):
            return items
        }
    }

    init(original: PathSectionModel, items: [PathSectionItemModel]) {
        switch original {
        case .mapSection(_):
            self = .mapSection(items: items)
        case .optionsSection(_):
            self = .optionsSection(items: items)
        case .pointsSection(_):
            self = .pointsSection(items: items)
        }
    }
}

enum PathSectionItemModel {
    case pathMapItem(path: Path)
    case pathDisplayModeItem(available: [PathDisplayMode], selected: PathDisplayMode)
    case pathFilterItem(available: [PathFilter], selected: PathFilter)
    case pathPointItem(pathPoint: PathPoint)
}
