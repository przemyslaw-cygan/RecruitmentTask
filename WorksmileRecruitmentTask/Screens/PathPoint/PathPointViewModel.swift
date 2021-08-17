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
    private let destinationSubject = PublishSubject<AppScreenDestination>()
    private let sectionsSubject = BehaviorSubject<[PathPointSectionModel]>(value: [])

    init(pathName: String, pathPointIndex: Int, pathProvider: PathProvider) {
        self.pathName = pathName
        self.pathPointIndex = pathPointIndex
        self.pathProvider = pathProvider
    }
}

extension PathPointViewModel {
    var destination: Driver<AppScreenDestination> {
        destinationSubject
            .asDriver(onErrorJustReturn: .error(error: nil))
            .compactMap { $0 }
    }

    var sections: Driver<[PathPointSectionModel]> {
        sectionsSubject
            .asDriver(onErrorJustReturn: [])
    }

    func initialize() {
        pathProvider.getPathPoint(with: pathName, at: pathPointIndex)
            .map { Self.createSections(for: $0) }
            .subscribe(
                onNext: { [weak self] in self?.sectionsSubject.onNext($0) },
                onError: { [weak self] in self?.destinationSubject.onNext(.error(error: $0)) }
            )
            .disposed(by: disposeBag)
    }
}

private extension PathPointViewModel {
    static func createSections(for pathPoint: PathPoint) -> [PathPointSectionModel] {
        var sections = [PathPointSectionModel]()
        sections.append(.mapSection(items: [.pathPointMapItem(pathPoint: pathPoint)]))
        sections.append(.infoSection(items: [
            .pathPointInfoItem(
                name: AppString.PathPointScreen.pointInfoCellTimestamp.rawValue.localized,
                value: String(pathPoint.timestamp)
            ),
            .pathPointInfoItem(
                name: AppString.PathPointScreen.pointInfoCellLatitude.rawValue.localized,
                value: String(pathPoint.latitude)
            ),
            .pathPointInfoItem(
                name: AppString.PathPointScreen.pointInfoCellLongitude.rawValue.localized,
                value: String(pathPoint.longitude)
            ),
            .pathPointInfoItem(
                name: AppString.PathPointScreen.pointInfoCellAltitude.rawValue.localized,
                value: String(pathPoint.altitude)
            ),
            .pathPointInfoItem(
                name: AppString.PathPointScreen.pointInfoCellDistance.rawValue.localized,
                value: String(pathPoint.distance)
            ),
            .pathPointInfoItem(
                name: AppString.PathPointScreen.pointInfoCellAccuracy.rawValue.localized,
                value: String(pathPoint.accuracy)
            )
        ]))
        return sections
    }
}
