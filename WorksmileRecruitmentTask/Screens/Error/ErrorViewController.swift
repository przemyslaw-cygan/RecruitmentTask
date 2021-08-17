//
//  ErrorViewController.swift
//  WorksmileRecruitmentTask
//
//  Created by Przemysław Cygan on 17/08/2021.
//

import UIKit
import SnapKit

class ErrorViewController: UIViewController {
    private let errorLabel = UILabel()

    private let error: Error?

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
    func setupHierarchy() {
        view.addSubview(errorLabel)
    }

    func setupAutolayout() {
        errorLabel.snp.makeConstraints {
            $0.edges.equalToSuperview()
        }
    }

    func setupProperties() {
        title = "Error"
        errorLabel.numberOfLines = 0
        errorLabel.textAlignment = .center
        errorLabel.text = error?.localizedDescription
    }
}
