//
//  PathPointViewModel.swift
//  WorksmileRecruitmentTask
//
//  Created by Przemysław Cygan on 17/08/2021.
//

import Foundation
import RxSwift
import RxCocoa

class PathPointViewModel {
    private let pathName: String
    private let pathPointIndex: Int
    private let pathProvider: PathProvider

    private let disposeBag = DisposeBag()
    private let sectionsSubject = PublishSubject<[PathPointSectionModel]>()

    init(pathName: String, pathPointIndex: Int, pathProvider: PathProvider) {
        self.pathName = pathName
        self.pathPointIndex = pathPointIndex
        self.pathProvider = pathProvider
    }
}

extension PathPointViewModel {
    var sections: Driver<[PathPointSectionModel]> {
        sectionsSubject
            .asDriver(onErrorJustReturn: [])
    }

    func initialize() {
        pathProvider.getPathPoint(with: pathName, at: pathPointIndex)
            .map { Self.createSections(for: $0) }
            .subscribe(
                onNext: { [weak self] in self?.sectionsSubject.onNext($0) },
                onError: { print($0) }
            )
            .disposed(by: disposeBag)
    }
}

private extension PathPointViewModel {
    static func createSections(for pathPoint: PathPoint) -> [PathPointSectionModel] {
        var sections = [PathPointSectionModel]()
        sections.append(.mapSection(title: "map", items: [.pathPointMapItem(pathPoint: pathPoint)]))
        var infoItems = [PathPointSectionItemModel]()
        infoItems.append(.pathPointInfoItem(name: "timestamp", value: String(pathPoint.timestamp)))
        infoItems.append(.pathPointInfoItem(name: "latitude", value: String(pathPoint.latitude)))
        infoItems.append(.pathPointInfoItem(name: "longitude", value: String(pathPoint.longitude)))
        infoItems.append(.pathPointInfoItem(name: "altitude", value: String(pathPoint.altitude)))
        infoItems.append(.pathPointInfoItem(name: "distance", value: String(pathPoint.distance)))
        infoItems.append(.pathPointInfoItem(name: "accuracy", value: String(pathPoint.accuracy)))
        sections.append(.infoSection(title: "info", items: infoItems))
        return sections
    }
}
