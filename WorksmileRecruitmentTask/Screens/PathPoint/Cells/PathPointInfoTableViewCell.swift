//
//  PathPointInfoTableViewCell.swift
//  WorksmileRecruitmentTask
//
//  Created by Przemysław Cygan on 17/08/2021.
//

import UIKit
import SnapKit

class PathPointInfoTableViewCell: UITableViewCell {
    private let infoView = InfoView()

    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        setupView()
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

extension PathPointInfoTableViewCell {
    func configure(name: String, value: String) {
        infoView.name = name
        infoView.value = value
    }
}

extension PathPointInfoTableViewCell: ViewBuilder {
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
