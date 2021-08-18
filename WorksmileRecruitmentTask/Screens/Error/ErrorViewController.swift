//
//  ErrorViewController.swift
//  WorksmileRecruitmentTask
//
//  Created by Przemysław Cygan on 17/08/2021.
//

import UIKit
import SnapKit

class ErrorViewController: UIViewController {
    private let error: Error?
    private let errorLabel = UILabel()

    init(with error: Error?) {
        self.error = error
        super.init(nibName: nil, bundle: nil)
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        setupView()
    }
}

extension ErrorViewController: ViewBuilder {
    func setupViewHierarchy() {
        view.addSubview(errorLabel)
    }

    func setupViewAutolayout() {
        errorLabel.snp.makeConstraints { $0.edges.equalToSuperview().inset(40) }
    }

    func setupViewProperties() {
        title = AppString.ErrorScreen.title.rawValue.localized
        errorLabel.numberOfLines = 0
        errorLabel.textAlignment = .center
        errorLabel.text = error?.localizedDescription
    }
}
