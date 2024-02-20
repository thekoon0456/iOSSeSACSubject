//
//  NewListViewController.swift
//  SeSAC_TodoProject
//
//  Created by Deokhun KIM on 2/20/24.
//

import UIKit

import SnapKit

enum NewListSection: CaseIterable {
    case inputTitle
    case colors
    case icons
}

final class NewListViewController: BaseViewController {
    
    // MARK: - Properties
    
    lazy var cancelButton = UIBarButtonItem(title: "취소",
                                                    style: .plain,
                                                    target: self,
                                                    action: #selector(cancelButtonTapped))
    lazy var addButton = UIBarButtonItem(title: "추가",
                                                 style: .plain,
                                                 target: self,
                                                 action: #selector(addButtonTapped))
    
    private let titleItems = ["새로운 목록", "템플릿"]
    private lazy var primarySeg = UISegmentedControl(items: titleItems).then {
        $0.selectedSegmentIndex = 0
    }
    
    private lazy var tableView = UITableView(frame: .zero, style: .insetGrouped).then {
        $0.dataSource = self
        $0.delegate = self
        $0.register(InputTitleCell.self, forCellReuseIdentifier: InputTitleCell.identifier)
        $0.register(SelectConfigureCell.self, forCellReuseIdentifier: SelectConfigureCell.identifier)
    }
    
    // MARK: - Selectors
    
    @objc func cancelButtonTapped() {
        navigationController?.dismiss(animated: true)
    }
    
    @objc func addButtonTapped() {
//        todoRepo.createItem(todo)
        dismiss(animated: true)
    }
    
    // MARK: - Helpers
    
    override func configureHierarchy() {
        view.addSubviews(primarySeg, tableView)
    }
    
    override func configureLayout() {
        primarySeg.snp.makeConstraints { make in
            make.top.equalTo(view.safeAreaLayoutGuide)
            make.width.equalTo(tableView.snp.width)
            make.centerX.equalToSuperview()
        }
        
        tableView.snp.makeConstraints { make in
            make.top.equalTo(primarySeg.snp.bottom).offset(12)
            make.leading.trailing.bottom.equalToSuperview()
        }
    }
    
    override func configureView() {
        navigationItem.title = "새로운 목록"
        navigationItem.leftBarButtonItem = cancelButton
        navigationItem.rightBarButtonItem = addButton
        view.backgroundColor = .black
        addButton.isEnabled = false
    }
}

extension NewListViewController: UITableViewDelegate, UITableViewDataSource {
    
    func numberOfSections(in tableView: UITableView) -> Int {
        NewListSection.allCases.count
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        1
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        switch NewListSection.allCases[indexPath.section] {
        case .inputTitle:
            guard let cell = tableView.dequeueReusableCell(withIdentifier: InputTitleCell.identifier, for: indexPath) as? InputTitleCell else { return UITableViewCell() }
            return cell
        case .colors:
            guard let cell = tableView.dequeueReusableCell(withIdentifier: SelectConfigureCell.identifier, for: indexPath) as? SelectConfigureCell else { return UITableViewCell() }
            cell.list = [CircleConfig(imageName: "", color: .systemRed),
                         CircleConfig(imageName: "", color: .systemOrange),
                         CircleConfig(imageName: "", color: .systemYellow),
                         CircleConfig(imageName: "", color: .systemGreen),
                         CircleConfig(imageName: "", color: .systemCyan),
                         CircleConfig(imageName: "", color: .systemBlue)]
            return cell
        case .icons:
            guard let cell = tableView.dequeueReusableCell(withIdentifier: SelectConfigureCell.identifier, for: indexPath) as? SelectConfigureCell else { return UITableViewCell() }
            cell.list = [CircleConfig(imageName: "list.bullet"),
                         CircleConfig(imageName: "bookmark"),
                         CircleConfig(imageName: "mappin"),
                         CircleConfig(imageName: "gift"),
                         CircleConfig(imageName: "birthday.cake"),
                         CircleConfig(imageName: "graduationcap")]
            return cell
        }
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        UITableView.automaticDimension
    }
}
