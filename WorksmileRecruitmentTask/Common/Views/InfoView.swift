//
//  InfoView.swift
//  WorksmileRecruitmentTask
//
//  Created by Przemysław Cygan on 17/08/2021.
//

import UIKit
import SnapKit

class InfoView: UIView {
    var name: String? {
        didSet { updateName()}
    }

    var value: String? {
        didSet { updateValue() }
    }

    private let mainStackView = UIStackView()
    private let nameLabel = UILabel()
    private let valueLabel = UILabel()

    init() {
        super.init(frame: .zero)
        setupView()
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

extension InfoView: ViewBuilder {
    func setupHierarchy() {
        addSubview(mainStackView)
        mainStackView.addArrangedSubview(nameLabel)
        mainStackView.addArrangedSubview(valueLabel)
    }

    func setupAutolayout() {
        mainStackView.snp.makeConstraints {
            $0.edges.equalToSuperview().inset(UIEdgeInsets(top: 10, left: 20, bottom: 10, right: 20))
        }
    }

    func setupProperties() {
        mainStackView.axis = .vertical
        mainStackView.spacing = 5
        nameLabel.textColor = .secondaryLabel
        nameLabel.font = .systemFont(ofSize: 10)
        valueLabel.font = .systemFont(ofSize: 14)
    }
}

private extension InfoView {
    func updateName() {
        nameLabel.text = name
    }

    func updateValue() {
        valueLabel.text = value
    }
}
