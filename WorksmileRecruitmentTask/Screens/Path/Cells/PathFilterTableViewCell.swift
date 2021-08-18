//
//  PathFilterTableViewCell.swift
//  WorksmileRecruitmentTask
//
//  Created by Przemysław Cygan on 17/08/2021.
//

import UIKit
import SnapKit
import RxSwift
import RxCocoa

protocol PathFilterTableViewCellDelegate: AnyObject {
    func didSelectPathFilter(_ filter: PathFilter)
}

class PathFilterTableViewCell: UITableViewCell {
    weak var delegate: PathFilterTableViewCellDelegate?
    private var pathFilters: [PathFilter]?

    private let disposeBag = DisposeBag()
    private let segmentedControl = UISegmentedControl()

    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        setupView()

        segmentedControl.rx.selectedSegmentIndex
            .subscribe(onNext: { [weak self] index in
                guard let pathFilters = self?.pathFilters, pathFilters.indices.contains(index) else { return }
                self?.delegate?.didSelectPathFilter(pathFilters[index])
            })
            .disposed(by: disposeBag)
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

extension PathFilterTableViewCell {
    func configure(available: [PathFilter], selected: PathFilter) {
        pathFilters = available
        segmentedControl.setItems(available.map { $0.title })
        segmentedControl.selectedSegmentIndex = available.firstIndex(of: selected) ?? 0
    }
}

extension PathFilterTableViewCell: ViewBuilder {
    func setupViewHierarchy() {
        contentView.addSubview(segmentedControl)
    }

    func setupViewAutolayout() {
        segmentedControl.snp.makeConstraints { $0.edges.equalToSuperview().inset(10) }
    }

    func setupViewProperties() {
        selectionStyle = .none
    }
}
