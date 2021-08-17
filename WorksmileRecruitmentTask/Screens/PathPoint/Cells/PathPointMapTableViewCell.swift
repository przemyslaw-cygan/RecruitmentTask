//
//  PathPointMapTableViewCell.swift
//  WorksmileRecruitmentTask
//
//  Created by Przemysław Cygan on 17/08/2021.
//

import UIKit
import SnapKit

class PathPointMapTableViewCell: UITableViewCell {
    private let mapView = MapView()

    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        setupView()
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

extension PathPointMapTableViewCell {
    func configure(pathPoint: PathPoint) {
        mapView.paths = nil
        mapView.points = [pathPoint]
    }
}

extension PathPointMapTableViewCell: ViewBuilder {
    func setupHierarchy() {
        contentView.addSubview(mapView)
    }

    func setupAutolayout() {
        mapView.snp.makeConstraints {
            $0.edges.equalToSuperview()
            $0.height.equalTo(320)
        }
    }

    func setupProperties() {
        selectionStyle = .none
    }
}