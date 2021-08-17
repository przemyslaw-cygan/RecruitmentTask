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
    private let pathFilterSubject = BehaviorSubject<PathFilter>(value: .raw)
    private let sectionsSubject = BehaviorSubject<[PathSectionModel]>(value: [])

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
        sectionsSubject
            .asDriver(onErrorJustReturn: [])
    }

    func initialize() {
        Observable.combineLatest(pathProvider.getPath(with: pathName), pathFilterSubject)
            .map { $1.apply(for: $0) }
            .map { Self.createSections(for: $0) }
            .subscribe(
                onNext: { [weak self] in self?.sectionsSubject.onNext($0) },
                onError: { [weak self] in self?.destinationSubject.onNext(.error(error: $0)) }
            )
            .disposed(by: disposeBag)
    }

    func apply(pathFilter: PathFilter) {
        pathFilterSubject.onNext(pathFilter)
    }

    func select(pathIndex: Int) {
        destinationSubject.onNext(.pathPoint(pathName: pathName, pathIndex: pathIndex))
    }
}

private extension PathViewModel {
    static func createSections(for path: Path) -> [PathSectionModel] {
        var sections = [PathSectionModel]()
        sections.append(.mapSection(items: [.pathMapItem(path: path)]))
        sections.append(.pointsSection(items: path.map { .pathPointItem(pathPoint: $0) }))
        return sections
    }
}
