//
//  PathViewModel.swift
//  WorksmileRecruitmentTask
//
//  Created by Przemysław Cygan on 17/08/2021.
//

import Foundation
import RxSwift
import RxCocoa

class PathViewModel {
    private let pathName: String
    private let pathProvider: PathProvider

    private let disposeBag = DisposeBag()
    private let destinationSubject = PublishSubject<AppScreenDestination>()
    private let pathSubject = BehaviorSubject<Path>(value: [])
    private let pathFilterSubject = BehaviorSubject<PathFilter>(value: .raw)
    private let pathDisplayModeSubject = BehaviorSubject<PathDisplayMode>(value: .all)

    init(pathName: String, pathProvider: PathProvider) {
        self.pathName = pathName
        self.pathProvider = pathProvider
    }
}

extension PathViewModel {
    var destination: Driver<AppScreenDestination> {
        destinationSubject
            .asDriver(onErrorJustReturn: .error(error: nil))
            .compactMap { $0 }
    }

    var sections: Driver<[PathSectionModel]> {
        Observable.combineLatest(pathSubject, pathFilterSubject, pathDisplayModeSubject)
            .map { Self.createSections(for: $0, filter: $1, displayMode: $2) }
            .asDriver(onErrorJustReturn: [])
    }

    func initialize() {
        pathProvider.getPath(with: pathName)
            .subscribe(
                onNext: { [weak self] in self?.pathSubject.onNext($0) },
                onError: { [weak self] in self?.destinationSubject.onNext(.error(error: $0)) }
            )
            .disposed(by: disposeBag)
    }

    func select(pathPoint: PathPoint) {
        guard
            let path = try? pathSubject.value(),
            let pathIndex = path.firstIndex(of: pathPoint)
        else { return }
        destinationSubject.onNext(.pathPoint(pathName: pathName, pathIndex: pathIndex))
    }
}

extension PathViewModel: PathDisplayModeTableViewCellDelegate {
    func didSelectPathDisplayMode(_ displayMode: PathDisplayMode) {
        pathDisplayModeSubject.onNext(displayMode)
    }
}
extension PathViewModel: PathFilterTableViewCellDelegate {
    func didSelectPathFilter(_ filter: PathFilter) {
        pathFilterSubject.onNext(filter)
    }
}

private extension PathViewModel {
    static func createSections(for path: Path, filter: PathFilter, displayMode: PathDisplayMode) -> [PathSectionModel] {
        let filteredPath = filter.apply(for: path)
        let listPath: Path

        switch displayMode {
        case .all:
            listPath = path
        case .accepted:
            listPath = filteredPath
        case .rejected:
            listPath = path.difference(from: filteredPath)
        }

        var sections = [PathSectionModel]()
        sections.append(.mapSection(items: [.pathMapItem(path: filteredPath)]))
        sections.append(.optionsSection(items: [
            .pathFilterItem(
                available: [.raw, .distance(max: 0.5), .distanceAlt(max: 0.5)],
                selected: filter
            ),
            .pathDisplayModeItem(
                available: [.all, .accepted, .rejected],
                selected: displayMode
            )
        ]))
        sections.append(.pointsSection(items: listPath.map { .pathPointItem(pathPoint: $0) }))
        return sections
    }
}
