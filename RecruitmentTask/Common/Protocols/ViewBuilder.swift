//
//  ViewBuilder.swift
//  RecruitmentTask
//
//  Created by Przemysław Cygan on 17/08/2021.
//

import Foundation

protocol ViewBuilder {
    func setupViewHierarchy()
    func setupViewAutolayout()
    func setupViewProperties()
}

extension ViewBuilder {
    func setupView() {
        setupViewHierarchy()
        setupViewAutolayout()
        setupViewProperties()
    }
}
