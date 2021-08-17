//
//  MapTableViewCell.swift
//  WorksmileRecruitmentTask
//
//  Created by Przemysław Cygan on 17/08/2021.
//

import UIKit
import MapKit
import SnapKit

class MapView: UIView {
    var paths: [Path]? {
        didSet { updatePaths()}
    }

    var points: [PathPoint]? {
        didSet { updatePoints() }
    }

    private let mapView = MKMapView()

    init() {
        super.init(frame: .zero)
        setupView()
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

extension MapView: ViewBuilder {
    func setupHierarchy() {
        addSubview(mapView)
    }

    func setupAutolayout() {
        mapView.snp.makeConstraints {
            $0.edges.equalToSuperview()
        }
    }

    func setupProperties() {
    }
}

private extension MapView {
    func updatePaths() {
    }

    func updatePoints() {
    }
}
