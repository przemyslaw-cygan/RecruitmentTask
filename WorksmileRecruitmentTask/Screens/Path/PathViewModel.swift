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
    private let sectionsSubject = BehaviorSubject<[PathSectionModel]>(value: [])
    private let pathFilterSubject = BehaviorSubject<PathFilter>(value: .raw)

    init(pathName: String, pathProvider: PathProvider) {
        self.pathName = pathName
        self.pathProvider = pathProvider
    }
}

extension PathViewModel {
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
                onError: { print($0) }
            )
            .disposed(by: disposeBag)
    }

    func setPathFilter(_ pathFilter: PathFilter) {
        pathFilterSubject.onNext(pathFilter)
    }

    static func createSections(for path: Path) -> [PathSectionModel] {
        var sections = [PathSectionModel]()
        sections.append(.mapSection(title: "map", items: [.pathMapItem(path: path)]))
        sections.append(.pointsSection(title: "points", items: path.map { .pathPointItem(pathPoint: $0) }))
        return sections
    }
}
