//
//  NewTodoController.swift
//  SeSAC_TodoProject
//
//  Created by Deokhun KIM on 2/14/24.
//

import UIKit

import RealmSwift

final class NewTodoController: BaseViewController {
    
    // MARK: - Properties
    
    private var todo = Todo()
    
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
        $0.register(textCell.self, forCellReuseIdentifier: textCell.identifier)
        $0.register(InputHeaderCell.self, forCellReuseIdentifier: InputHeaderCell.identifier)
    }
    
    // MARK: - Lifecycles
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        notiAddObserver(name: "우선순위")
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        
        postNotification(name: "추가", userInfo: nil)

    }
    
    deinit {
        NotificationCenter.default.removeObserver(self)
    }
    
    // MARK: - Selectors
    
    @objc func cancelButtonTapped() {
        navigationController?.dismiss(animated: true)
    }
    
    @objc func addButtonTapped() {
        addRealm(data: todo)
        dismiss(animated: true)
    }
    
    @objc func receivedNotification(notification: NSNotification) {
        guard let data = notification.userInfo?["우선순위"] as? String else { return }
        InputSection.valueList[3] = data
        todo.priority = data
        tableView.reloadData()
    }
    
    // MARK: - Helpers
    
    private func postNotification(name: String, userInfo: [String: Any]?) {
        NotificationCenter.default.post(name: NSNotification.Name(name),
                                        object: nil,
                                        userInfo: userInfo)
    }
    
    private func addRealm<T: Object>(data: T) {
        let realm = try! Realm()

        try! realm.write {
            realm.add(data)
        }
    }
    
    private func notiAddObserver(name: String) {
        NotificationCenter.default.addObserver(self,
                                               selector: #selector(receivedNotification(notification:)),
                                               name: NSNotification.Name(name),
                                               object: nil)
    }
    
    private func getDateString(_ date: Date?) -> String {
        let formatter = DateFormatter()
        formatter.locale = Locale(identifier: "ko_kr")
        formatter.timeZone = TimeZone(abbreviation: "KST")
        formatter.dateFormat = "yyyy년 M월 d일 a hh:mm"
        return formatter.string(from: date ?? Date())
    }
    
    override func configureHierarchy() {
        view.addSubviews(tableView)
    }
    
    override func configureLayout() {
        tableView.snp.makeConstraints { make in
            make.edges.equalTo(view.safeAreaLayoutGuide)
        }
    }
    
    override func configureView() {
        super.configureView()
        navigationItem.title = "새로운 할 일"
        navigationItem.leftBarButtonItem = cancelButton
        navigationItem.rightBarButtonItem = addButton
        view.backgroundColor = .secondarySystemBackground
        addButton.isEnabled = false
    }
}

// MARK: - TextField

extension NewTodoController: UITextFieldDelegate {
    
    func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool {
        guard let input = textField.text else { return true }
        
        let text = (input as NSString).replacingCharacters(in: range, with: string)
        
        if text.isEmpty {
            addButton.isEnabled = false
        } else {
            addButton.isEnabled = true
        }
        
        return true
    }
}

// MARK: - TableView

extension NewTodoController: UITableViewDelegate, UITableViewDataSource, EndDateDelegate {
    //endDate업데이트
    func setDate(date: Date?) {
        InputSection.valueList[1] = getDateString(date)
        todo.endDate = date
        tableView.reloadData()
    }
    
    //section간 간격 조절
    func tableView(_ tableView: UITableView, viewForFooterInSection section: Int) -> UIView? {
        UIView()
    }
    
    func tableView(_ tableView: UITableView, heightForFooterInSection section: Int) -> CGFloat {
        1
    }
    
    //section 설정
    func numberOfSections(in tableView: UITableView) -> Int {
        InputSection.allCases.count
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        1
    }
    
    //tableViewCell
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        switch indexPath.section {
        case 0:
            guard let cell = tableView.dequeueReusableCell(withIdentifier: InputHeaderCell.identifier, for: indexPath) as? InputHeaderCell else {
                return UITableViewCell()
            }
            cell.titleTextField.delegate = self
            todo.title = cell.titleTextField.text!
            todo.memo = cell.memoTextField.text
            
            return cell
        default:
            guard let cell = tableView.dequeueReusableCell(withIdentifier: textCell.identifier) as? textCell else {
                return UITableViewCell()
            }
            
            cell.configureCell(title: InputSection.allCases[indexPath.section].title,
                               value: InputSection.allCases[indexPath.section].value)
            
            return cell
        }
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        switch indexPath.section {
        case 0:
            break
        case 1:
            //delegate
            let vc = EndDateViewController()
            vc.delegate = self
            navigationController?.pushViewController(vc, animated: true)
        case 2:
            //closure
            let vc = TagViewController()
            vc.getTag = { tag in
                InputSection.valueList[2] = tag ?? ""
                self.todo.tag = tag
                self.tableView.reloadData()
            }
            navigationController?.pushViewController(vc, animated: true)
        case 3:
            //notificationCenter
            let vc = PrimaryViewController()
            navigationController?.pushViewController(vc, animated: true)
        case 4:
            let vc = AddImageViewController()
            navigationController?.pushViewController(vc, animated: true)
        default:
            return
        }
        
        tableView.deselectRow(at: indexPath, animated: true)
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
