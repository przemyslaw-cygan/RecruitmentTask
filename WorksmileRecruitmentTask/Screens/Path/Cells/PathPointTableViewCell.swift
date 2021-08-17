//
//  PathPointTableViewCell.swift
//  WorksmileRecruitmentTask
//
//  Created by Przemysław Cygan on 17/08/2021.
//

import UIKit
import SnapKit

class PathPointTableViewCell: UITableViewCell {
    private let infoView = InfoView()

    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        setupView()
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

extension PathPointTableViewCell {
    func configure(pathPoint: PathPoint) {
        infoView.name = AppString.PathScreen.pointCellLabel.rawValue.localized
        infoView.value = "\(pathPoint.latitude), \(pathPoint.longitude), \(pathPoint.altitude)"
    }
}

extension PathPointTableViewCell: ViewBuilder {
    func setupHierarchy() {
        contentView.addSubview(infoView)
    }

    func setupAutolayout() {
        infoView.snp.makeConstraints {
            $0.edges.equalToSuperview()
        }
    }

    func setupProperties() {
        selectionStyle = .none
    }
}
