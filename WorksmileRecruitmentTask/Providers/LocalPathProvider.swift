//
//  LocalPathProviderService.swift
//  WorksmileRecruitmentTask
//
//  Created by Przemysław Cygan on 17/08/2021.
//

import Foundation
import RxSwift

class LocalPathProvider {
    private var paths = [String: Path]()

    private func readLocalFile(fileName: String) throws -> Data {
        guard let filePath = Bundle.main.path(forResource: fileName, ofType: "json") else {
            throw PathProviderError.pathNotFound
        }
        return try Data(contentsOf: URL(fileURLWithPath: filePath))
    }
}

extension LocalPathProvider: PathProvider {
    func getPath(with pathName: String) -> Observable<Path> {
        Observable.create { observer in
            do {
                if let path = self.paths[pathName] {
                    observer.onNext(path)
                } else {
                    let data = try self.readLocalFile(fileName: pathName)
                    let pathPoints = try JSONDecoder().decode(Path.self, from: data)
                    self.paths[pathName] = pathPoints
                    observer.onNext(pathPoints)
                }
                observer.onCompleted()
            } catch {
                observer.onError(error)
            }
            return Disposables.create()
        }.share()
    }

    func getPathPoint(with pathName: String, at index: Int) -> Observable<PathPoint> {
        getPath(with: pathName).map {
            guard $0.indices.contains(index) else {
                throw PathProviderError.pathPointNotFound
            }
            return $0[index]
        }
    }
}
