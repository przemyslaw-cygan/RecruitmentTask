//
//  PathPointViewController.swift
//  WorksmileRecruitmentTask
//
//  Created by Przemysław Cygan on 17/08/2021.
//

import UIKit
import SnapKit
import RxSwift
import RxCocoa
import RxDataSources

class PathPointViewController: UIViewController {
    private let viewModel: PathPointViewModel

    private let disposeBag = DisposeBag()
    private let tableView = UITableView()

    init(with viewModel: PathPointViewModel) {
        self.viewModel = viewModel
        super.init(nibName: nil, bundle: nil)
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        setupView()
        setupTable()
        bindViewModel()
        viewModel.initialize()
    }
}

extension PathPointViewController: ViewBuilder {
    func setupViewHierarchy() {
        view.addSubview(tableView)
    }

    func setupViewAutolayout() {
        tableView.snp.makeConstraints { $0.edges.equalToSuperview() }
    }

    func setupViewProperties() {
        title = AppString.PathPointScreen.title.rawValue.localized
        tableView.separatorInset = .init(top: 10, left: 10, bottom: 10, right: 10)
    }
}

extension PathPointViewController: TableDataSourceApplicable {
    typealias SectionModel = PathPointSectionModel

    func registerTableViewCells() {
        tableView.register(PathPointMapTableViewCell.self, forCellReuseIdentifier: "pathPointMapCell")
        tableView.register(PathPointInfoTableViewCell.self, forCellReuseIdentifier: "pathPointInfoCell")
    }

    func bindTableView() {
        viewModel.sections
            .drive(tableView.rx.items(dataSource: tableViewDataSource()))
            .disposed(by: disposeBag)
    }

    func tableViewDataSource() -> RxTableViewSectionedReloadDataSource<SectionModel> {
        return .init(
            configureCell: { dataSource, table, indexPath, _ in
                switch dataSource[indexPath] {
                case .pathPointMapItem(let pathPoint):
                    let cell: PathPointMapTableViewCell = table.dequeueReusableCell(
                        withIdentifier: "pathPointMapCell",
                        for: indexPath
                    )
                    cell.configure(pathPoint: pathPoint)
                    return cell
                case .pathPointInfoItem(let name, let value):
                    let cell: PathPointInfoTableViewCell = table.dequeueReusableCell(
                        withIdentifier: "pathPointInfoCell",
                        for: indexPath
                    )
                    cell.configure(name: name, value: value)
                    return cell
                }
            }
        )
    }
}

private extension PathPointViewController {
    func bindViewModel() {
        viewModel.destination
            .drive(onNext: { [weak self] in self?.handleDestination($0) })
            .disposed(by: disposeBag)
    }

    func handleDestination(_ destination: AppScreen) {
        navigationController?.pushViewController(destination.viewController, animated: true)
    }
}
