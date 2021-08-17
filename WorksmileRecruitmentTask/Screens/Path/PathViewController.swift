//
//  PathViewController.swift
//  WorksmileRecruitmentTask
//
//  Created by Przemysław Cygan on 17/08/2021.
//

import UIKit
import SnapKit
import RxSwift
import RxDataSources

class PathViewController: UIViewController {
    private let tableView = UITableView()
    private let viewModel = PathViewModel(pathName: "ExamplePath", pathProvider: LocalPathProvider())
    private let disposeBag = DisposeBag()

    override func viewDidLoad() {
        super.viewDidLoad()
        setupTableView()
        registerTableViewCells()
        bindTableView()
        viewModel.initialize()
    }
}

extension PathViewController: TableViewDataSourceApplicable {
    typealias SectionModel = PathSectionModel

    func setupTableView() {
        view.addSubview(tableView)
        tableView.snp.makeConstraints { $0.edges.equalToSuperview() }
    }

    func registerTableViewCells() {
        tableView.register(UITableViewCell.self, forCellReuseIdentifier: "pathMapCell")
        tableView.register(UITableViewCell.self, forCellReuseIdentifier: "pathPointCell")
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
                case .pathMapItem(let path):
                    let cell: UITableViewCell = table.dequeueReusableCell(
                        withIdentifier: "pathMapCell",
                        for: indexPath
                    )
                    cell.textLabel?.text = "map"
                    return cell
                case .pathPointItem(let pathPoint):
                    let cell: UITableViewCell = table.dequeueReusableCell(
                        withIdentifier: "pathPointCell",
                        for: indexPath
                    )
                    cell.textLabel?.text = "\(pathPoint)"
                    return cell
                }
            }
        )
    }
}
