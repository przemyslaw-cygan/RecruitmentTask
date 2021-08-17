//
//  PathDisplayModeTableViewCell.swift
//  WorksmileRecruitmentTask
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

    private let disposeBag = DisposeBag()
    private var pathDisplayModes = [PathDisplayMode]()

    private let segmentedControl = UISegmentedControl()

    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        setupView()

        segmentedControl.rx.selectedSegmentIndex
            .subscribe(onNext: { [weak self] index in
                guard let self = self, self.pathDisplayModes.indices.contains(index) else { return }
                self.delegate?.didSelectPathDisplayMode(self.pathDisplayModes[index])
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
        segmentedControl.removeAllSegments()
        available.enumerated().forEach {
            segmentedControl.insertSegment(withTitle: $0.element.title, at: $0.offset, animated: false)
        }
        segmentedControl.selectedSegmentIndex = available.firstIndex(of: selected) ?? 0
    }
}

extension PathDisplayModeTableViewCell: ViewBuilder {
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
