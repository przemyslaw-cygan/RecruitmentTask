//
//  AppString.swift
//  WorksmileRecruitmentTask
//
//  Created by Przemysław Cygan on 17/08/2021.
//

import Foundation

enum AppString {
    enum ErrorScreen: String {
        case title = "errorScreen.title"
    }

    enum PathScreen: String {
        case title = "pathScreen.title"
        case pointCellLabel = "pathScreen.pointCell.label"
    }

    enum PathPointScreen: String {
        case title = "pathPointScreen.title"
        case pointInfoCellTimestamp = "pathPointScreen.pointInfoCell.timestamp"
        case pointInfoCellLatitude = "pathPointScreen.pointInfoCell.latitude"
        case pointInfoCellLongitude = "pathPointScreen.pointInfoCell.longitude"
        case pointInfoCellAltitude = "pathPointScreen.pointInfoCell.altitude"
        case pointInfoCellDistance = "pathPointScreen.pointInfoCell.distance"
        case pointInfoCellAccuracy = "pathPointScreen.pointInfoCell.accuracy"
    }

    enum PathProviderError: String {
        case pathNotFound = "pathProviderError.pathNotFound"
        case pathPointNotFound = "pathProviderError.pathPointNotFound"
    }
}

extension String {
    var localized: String {
        NSLocalizedString(self, comment: "")
    }
}
