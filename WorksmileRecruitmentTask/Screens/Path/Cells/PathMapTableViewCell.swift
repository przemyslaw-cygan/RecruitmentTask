//
//  PathMapTableViewCell.swift
//  WorksmileRecruitmentTask
//
//  Created by Przemysław Cygan on 17/08/2021.
//

import UIKit
import SnapKit

class PathMapTableViewCell: UITableViewCell {
    private let mapView = MapView()

    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        setupView()
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

extension PathMapTableViewCell {
    func configure(path: Path) {
        mapView.paths = [path]
        mapView.points = nil
    }
}

extension PathMapTableViewCell: ViewBuilder {
    func setupViewHierarchy() {
        contentView.addSubview(mapView)
    }

    func setupViewAutolayout() {
        mapView.snp.makeConstraints {
            $0.edges.equalToSuperview()
            $0.height.equalTo(320)
        }
    }

    func setupViewProperties() {
        selectionStyle = .none
    }
}
