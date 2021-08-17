//
//  GenericTableViewController.swift
//  WorksmileRecruitmentTask
//
//  Created by Przemysław Cygan on 17/08/2021.
//

import Foundation
import RxDataSources

protocol TableViewDataSourceApplicable {
    associatedtype SectionModel: SectionModelType
    func setupTableView()
    func registerTableViewCells()
    func bindTableView()
    func tableViewDataSource() -> RxTableViewSectionedReloadDataSource<SectionModel>
}
