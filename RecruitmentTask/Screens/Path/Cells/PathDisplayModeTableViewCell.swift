//
//  PathDisplayModeTableViewCell.swift
//  RecruitmentTask
//
//  Created by Przemysław Cygan on 17/08/2021.
//

import UIKit
import SnapKit
import RxSwift
import RxCocoa

protocol PathDisplayModeTableViewCellDelegate: AnyObject {
    func didSelectPathDisplayMode(_ displayMode: PathDisplayMode)
}

class PathDisplayModeTableViewCell: UITableViewCell {
    weak var delegate: PathDisplayModeTableViewCellDelegate?
    private var pathDisplayModes: [PathDisplayMode]?

    private let disposeBag = DisposeBag()
    private let segmentedControl = UISegmentedControl()

    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        setupView()

        segmentedControl.rx.selectedSegmentIndex
            .subscribe(onNext: { [weak self] index in
                guard let pathDisplayModes = self?.pathDisplayModes, pathDisplayModes.indices.contains(index) else { return }
                self?.delegate?.didSelectPathDisplayMode(pathDisplayModes[index])
            })
            .disposed(by: disposeBag)
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

extension PathDisplayModeTableViewCell {
    func configure(available: [PathDisplayMode], selected: PathDisplayMode) {
        pathDisplayModes = available
        segmentedControl.setItems(available.map { $0.title })
        segmentedControl.selectedSegmentIndex = available.firstIndex(of: selected) ?? 0
    }
}

extension PathDisplayModeTableViewCell: ViewBuilder {
    func setupViewHierarchy() {
        contentView.addSubview(segmentedControl)
    }

    func setupViewAutolayout() {
        segmentedControl.snp.makeConstraints { $0.edges.equalToSuperview().inset(10)  }
    }

    func setupViewProperties() {
        selectionStyle = .none
    }
}
