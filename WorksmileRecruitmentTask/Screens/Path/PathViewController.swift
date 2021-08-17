//
//  PathViewController.swift
//  WorksmileRecruitmentTask
//
//  Created by Przemysław Cygan on 17/08/2021.
//

import UIKit
import SnapKit
import RxSwift
import RxCocoa
import RxDataSources

class PathViewController: UIViewController {
    private let disposeBag = DisposeBag()
    private let viewModel: PathViewModel

    private let tableView = UITableView()

    init(with viewModel: PathViewModel) {
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

        viewModel.destination
            .drive(onNext: { [weak self] in self?.handleDestination($0) })
            .disposed(by: disposeBag)

        viewModel.initialize()
    }
}

extension PathViewController: ViewBuilder {
    func setupHierarchy() {
        view.addSubview(tableView)
    }

    func setupAutolayout() {
        tableView.snp.makeConstraints {
            $0.edges.equalToSuperview()
        }
    }

    func setupProperties() {
        title = AppString.PathScreen.title.rawValue.localized
        tableView.separatorInset = .init(top: 10, left: 10, bottom: 10, right: 10)
    }
}

extension PathViewController: TableDataSourceApplicable {
    typealias SectionModel = PathSectionModel

    func registerTableViewCells() {
        tableView.register(PathMapTableViewCell.self, forCellReuseIdentifier: "pathMapCell")
        tableView.register(PathDisplayModeTableViewCell.self, forCellReuseIdentifier: "pathDisplayModeCell")
        tableView.register(PathFilterTableViewCell.self, forCellReuseIdentifier: "pathFilterCell")
        tableView.register(PathPointTableViewCell.self, forCellReuseIdentifier: "pathPointCell")
    }

    func bindTableView() {
        viewModel.sections
            .drive(tableView.rx.items(dataSource: tableViewDataSource()))
            .disposed(by: disposeBag)

        tableView.rx.modelSelected(SectionModel.Item.self)
            .subscribe(onNext: { [weak self] in
                switch $0 {
                case .pathMapItem, .pathDisplayModeItem, .pathFilterItem:
                    return
                case .pathPointItem(let pathPoint):
                    self?.viewModel.select(pathPoint: pathPoint)
                }
            })
            .disposed(by: disposeBag)
    }

    func tableViewDataSource() -> RxTableViewSectionedReloadDataSource<SectionModel> {
        return .init(
            configureCell: { [weak self] dataSource, table, indexPath, _ in
                switch dataSource[indexPath] {
                case .pathMapItem(let path):
                    let cell: PathMapTableViewCell = table.dequeueReusableCell(
                        withIdentifier: "pathMapCell",
                        for: indexPath
                    )
                    cell.configure(path: path)
                    return cell
                case .pathDisplayModeItem(let available, let selected):
                    let cell: PathDisplayModeTableViewCell = table.dequeueReusableCell(
                        withIdentifier: "pathDisplayModeCell",
                        for: indexPath
                    )
                    cell.configure(available: available, selected: selected)
                    cell.delegate = self?.viewModel
                    return cell
                case .pathFilterItem(let available, let selected):
                    let cell: PathFilterTableViewCell = table.dequeueReusableCell(
                        withIdentifier: "pathFilterCell",
                        for: indexPath
                    )
                    cell.configure(available: available, selected: selected)
                    cell.delegate = self?.viewModel
                    return cell
                case .pathPointItem(let pathPoint):
                    let cell: PathPointTableViewCell = table.dequeueReusableCell(
                        withIdentifier: "pathPointCell",
                        for: indexPath
                    )
                    cell.configure(pathPoint: pathPoint)
                    return cell
                }
            }
        )
    }
}

private extension PathViewController {
    func handleDestination(_ destination: AppScreenDestination) {
        navigationController?.pushViewController(destination.viewController, animated: true)
    }
}
