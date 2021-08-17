//
//  PathProviderService.swift
//  WorksmileRecruitmentTask
//
//  Created by Przemysław Cygan on 17/08/2021.
//

import Foundation
import RxSwift

enum PathProviderError: Error {
    case pathNotFound
    case pathPointNotFound
}

extension PathProviderError: LocalizedError {
    var errorDescription: String? {
        switch self {
        case .pathNotFound:
            return "Path not found"
        case .pathPointNotFound:
            return "Path Point not found"
        }
    }
}

protocol PathProvider {
    func getPath(with pathName: String) -> Observable<Path>
    func getPathPoint(with pathName: String, at index: Int) -> Observable<PathPoint>
}
