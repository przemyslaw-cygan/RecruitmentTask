//
//  PathPointViewController.swift
//  WorksmileRecruitmentTask
//
//  Created by Przemysław Cygan on 17/08/2021.
//

import UIKit
import SnapKit
import RxSwift
import RxDataSources

class PathPointViewController: UIViewController {
    private let tableView = UITableView()
    private let viewModel = PathPointViewModel(pathName: "ExamplePath", pathPointIndex: 0, pathProvider: LocalPathProvider())
    private let disposeBag = DisposeBag()

    override func viewDidLoad() {
        super.viewDidLoad()
        setupTableView()
        registerTableViewCells()
        bindTableView()
        viewModel.initialize()
    }
}

extension PathPointViewController: TableViewDataSourceApplicable {
    typealias SectionModel = PathPointSectionModel

    func setupTableView() {
        view.addSubview(tableView)
        tableView.snp.makeConstraints { $0.edges.equalToSuperview() }
    }

    func registerTableViewCells() {
        tableView.register(UITableViewCell.self, forCellReuseIdentifier: "pathPointMapCell")
        tableView.register(UITableViewCell.self, forCellReuseIdentifier: "pathPointInfoCell")
    }

    func bindTableView() {
        viewModel.sections
            .drive(tableView.rx.items(dataSource: tableViewDataSource()))
            .disposed(by: disposeBag)

        tableView.rx.modelSelected(SectionModel.Item.self)
            .bind { print($0) }
            .disposed(by: disposeBag)
    }

    func tableViewDataSource() -> RxTableViewSectionedReloadDataSource<SectionModel> {
        return .init(
            configureCell: { dataSource, table, indexPath, _ in
                switch dataSource[indexPath] {
                case .pathPointMapItem(let pathPoint):
                    let cell: UITableViewCell = table.dequeueReusableCell(
                        withIdentifier: "pathPointMapCell",
                        for: indexPath
                    )
                    cell.textLabel?.text = "map"
                    return cell
                case .pathPointInfoItem(let name, let value):
                    let cell: UITableViewCell = table.dequeueReusableCell(
                        withIdentifier: "pathPointInfoCell",
                        for: indexPath
                    )
                    cell.textLabel?.text = "\(name): \(value)"
                    return cell
                }
            }
        )
    }
}
