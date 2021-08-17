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

    private let disposeBag = DisposeBag()
    private var pathFilters = [PathFilter]()

    private let segmentedControl = UISegmentedControl()

    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        setupView()

        segmentedControl.rx.selectedSegmentIndex
            .subscribe(onNext: { [weak self] index in
                guard let self = self, self.pathFilters.indices.contains(index) else { return }
                self.delegate?.didSelectPathFilter(self.pathFilters[index])
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
        segmentedControl.removeAllSegments()
        available.enumerated().forEach {
            segmentedControl.insertSegment(withTitle: $0.element.title, at: $0.offset, animated: false)
        }
        segmentedControl.selectedSegmentIndex = available.firstIndex(of: selected) ?? 0
    }
}

extension PathFilterTableViewCell: ViewBuilder {
    func setupHierarchy() {
        contentView.addSubview(segmentedControl)
    }

    func setupAutolayout() {
        segmentedControl.snp.makeConstraints {
            $0.edges.equalToSuperview().inset(10)
        }
    }

    func setupProperties() {
        selectionStyle = .none
    }
}
