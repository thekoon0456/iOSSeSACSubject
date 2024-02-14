//
//  NewTodoController.swift
//  SeSAC_TodoProject
//
//  Created by Deokhun KIM on 2/14/24.
//

import UIKit

enum Section: CaseIterable {
    case input
    case endDate
    case tag
    case primary
    case addImage
    
    var value: String {
        switch self {
        case .input:
            ""
        case .endDate:
            "마감일"
        case .tag:
            "태그"
        case .primary:
            "우선 순위"
        case .addImage:
            "이미지 추가"
        }
    }
}

final class NewTodoController: BaseViewController {
    
    // MARK: - Properties
    
    private let list = ["마감일", "태그", "우선 순위", "이미지 추가"]
    
    private lazy var cancelButton = UIBarButtonItem(title: "취소",
                                               style: .plain,
                                               target: self,
                                               action: #selector(cancelButtonTapped))
    
    private lazy var addButton = UIBarButtonItem(title: "추가",
                                               style: .plain,
                                               target: self,
                                               action: #selector(addButtonTapped))
    
    private lazy var tableView = UITableView(frame: .zero, style: .insetGrouped).then {
        $0.dataSource = self
        $0.delegate = self
        $0.register(UITableViewCell.self, forCellReuseIdentifier: "id")
        $0.register(InputHeaderView.self, forCellReuseIdentifier: InputHeaderView.identifier)
    }
    
    // MARK: - Selectors
    
    @objc func cancelButtonTapped() {
        navigationController?.dismiss(animated: true)
    }
    
    @objc func addButtonTapped() {
        print(#function)
    }
    
    // MARK: - Helpers
    
    override func configureHierarchy() {
        view.addSubviews(tableView)
    }
    
    override func configureLayout() {
        tableView.snp.makeConstraints { make in
            make.edges.equalTo(view.safeAreaLayoutGuide)
        }
    }
    
    override func configureView() {
        navigationItem.title = "새로운 할 일"
        navigationItem.leftBarButtonItem = cancelButton
        navigationItem.rightBarButtonItem = addButton
        view.backgroundColor = .secondarySystemBackground
    }
}

extension NewTodoController: UITableViewDelegate, UITableViewDataSource {
    
    //section간 간격 조절
    func tableView(_ tableView: UITableView, viewForFooterInSection section: Int) -> UIView? {
        UIView()
    }
    
    func tableView(_ tableView: UITableView, heightForFooterInSection section: Int) -> CGFloat {
        1
    }
    
    //section 설정
    func numberOfSections(in tableView: UITableView) -> Int {
        Section.allCases.count
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        1
    }
    
    //tableViewCell
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        switch indexPath.section {
        case 0:
            guard let cell = tableView.dequeueReusableCell(withIdentifier: InputHeaderView.identifier, for: indexPath) as? InputHeaderView else {
                return UITableViewCell()
            }
            
            return cell
        default:
            guard let cell = tableView.dequeueReusableCell(withIdentifier: "id") else {
                return UITableViewCell()
            }
            
            cell.textLabel?.text = Section.allCases[indexPath.section].value
            cell.accessoryType = .disclosureIndicator
            return cell
        }
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        switch indexPath.section {
        case 0:
            return 150
        default:
            return 50
        }
    }
}
