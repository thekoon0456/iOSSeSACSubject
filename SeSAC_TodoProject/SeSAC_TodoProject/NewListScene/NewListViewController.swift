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
    
    private let todoListSectionRepo = TodoListSectionRepository()
    var circleConfig = CircleConfig(imageName: "", colorName: "systemGray") {
        didSet {
            tableView.reloadData()
        }
    }
    var dismissView: (() -> Void)?
    var inputText: String = ""
    let colorList = [CircleConfig(colorName: "systemRed"),
                     CircleConfig(colorName: "systemOrange"),
                     CircleConfig(colorName: "systemYellow"),
                     CircleConfig(colorName: "systemGreen"),
                     CircleConfig(colorName: "systemCyan"),
                     CircleConfig(colorName: "systemBlue")]
    
    let imageList = [CircleConfig(imageName: "list.bullet"),
                     CircleConfig(imageName: "bookmark"),
                     CircleConfig(imageName: "mappin"),
                     CircleConfig(imageName: "gift"),
                     CircleConfig(imageName: "birthday.cake"),
                     CircleConfig(imageName: "graduationcap")]
    
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
    
    // MARK: - Lifecycles
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        dismissView?()
    }
    
    // MARK: - Selectors
    
    @objc func cancelButtonTapped() {
        navigationController?.dismiss(animated: true)
    }
    
    @objc func addButtonTapped() {
        todoListSectionRepo.createItem(TodoListSection(colorName: circleConfig.colorName,
                                                       imageName: circleConfig.imageName,
                                                       todoListTitle: inputText))
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
            cell.bgView.backgroundColor = circleConfig.colorName.toUIColor()
            cell.circleImageView.image = UIImage(systemName: circleConfig.imageName)
            cell.textField.delegate = self
            return cell
        case .colors:
            guard let cell = tableView.dequeueReusableCell(withIdentifier: SelectConfigureCell.identifier, for: indexPath) as? SelectConfigureCell else { return UITableViewCell() }
            cell.selectItem = { config in
                self.circleConfig.colorName = config.colorName
            }
            cell.list = colorList
            return cell
        case .icons:
            guard let cell = tableView.dequeueReusableCell(withIdentifier: SelectConfigureCell.identifier, for: indexPath) as? SelectConfigureCell else { return UITableViewCell() }
            cell.selectItem = { config in
                self.circleConfig.imageName = config.imageName
            }
            cell.list = imageList
            return cell
        }
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        switch NewListSection.allCases[indexPath.section] {
        case .inputTitle:
            72 + 150
        case .colors:
            100
        case .icons:
            100
        }
    }
}

// MARK: - TextField

extension NewListViewController: UITextFieldDelegate {
    
    func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool {
        guard let input = textField.text,
              input.count < 10
        else { return false }
        
        let text = (input as NSString).replacingCharacters(in: range, with: string)
        let trimmedText = text.trimmingCharacters(in: .whitespaces)
        let hasWhiteSpace = text != trimmedText
        
        if text.isEmpty {
            addButton.isEnabled = false
        } else {
            addButton.isEnabled = true
        }
        
        self.inputText = text
        return !hasWhiteSpace
    }
}
