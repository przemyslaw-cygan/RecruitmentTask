//
//  AppScreen.swift
//  WorksmileRecruitmentTask
//
//  Created by Przemysław Cygan on 17/08/2021.
//

import UIKit

enum AppScreen {
    case inital
    case path(pathName: String)
    case pathPoint(pathName: String, pathIndex: Int)
    case error(error: Error?)
}

extension AppScreen {
    var viewController: UIViewController {
        switch self {
        case .inital:
            let viewModel = PathViewModel(
                pathName: "ExamplePath",
                pathProvider: LocalPathProvider()
            )
            return PathViewController(with: viewModel)
        case .path(let pathName):
            let viewModel = PathViewModel(
                pathName: pathName,
                pathProvider: LocalPathProvider()
            )
            return PathViewController(with: viewModel)
        case .pathPoint(let pathName, let pathIndex):
            let viewModel = PathPointViewModel(
                pathName: pathName,
                pathPointIndex: pathIndex,
                pathProvider: LocalPathProvider()
            )
            return PathPointViewController(with: viewModel)
        case .error(let error):
            return ErrorViewController(with: error)
        }
    }
}
