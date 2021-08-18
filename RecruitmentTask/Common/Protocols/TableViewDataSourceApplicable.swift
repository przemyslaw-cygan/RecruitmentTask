//
//  TableViewDataSourceApplicable.swift
//  RecruitmentTask
//
//  Created by Przemysław Cygan on 17/08/2021.
//

import Foundation
import RxDataSources

protocol TableDataSourceApplicable {
    associatedtype SectionModel: SectionModelType
    func registerTableViewCells()
    func bindTableView()
    func tableViewDataSource() -> RxTableViewSectionedReloadDataSource<SectionModel>
}

extension TableDataSourceApplicable {
    func setupTable() {
        registerTableViewCells()
        bindTableView()
    }
}
