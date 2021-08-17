//
//  ViewBuilder.swift
//  WorksmileRecruitmentTask
//
//  Created by Przemysław Cygan on 17/08/2021.
//

import Foundation

protocol ViewBuilder {
    func setupHierarchy()
    func setupAutolayout()
    func setupProperties()
}

extension ViewBuilder {
    func setupView() {
        setupHierarchy()
        setupAutolayout()
        setupProperties()
    }
}
