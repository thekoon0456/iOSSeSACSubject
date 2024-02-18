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
    
    private let todoRepo = TodoRepository()
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
        $0.register(TextCell.self, forCellReuseIdentifier: TextCell.identifier)
        $0.register(InputHeaderCell.self, forCellReuseIdentifier: InputHeaderCell.identifier)
    }
    
    lazy var tapGesture = UITapGestureRecognizer(target: self, action: #selector(viewTapped))
    
    // MARK: - Lifecycles
    
    override func viewDidLoad() {
        super.viewDidLoad()
        todoRepo.printURL()
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

    
    @objc func viewTapped() {
        view.endEditing(true)
        removeGesture()
    }
    
    @objc func cancelButtonTapped() {
        navigationController?.dismiss(animated: true)
    }
    
    @objc func addButtonTapped() {
        todoRepo.createItem(todo)
        dismiss(animated: true)
    }
    
    @objc func receivedNotification(notification: NSNotification) {
        if let data = notification.userInfo?["우선순위"] as? Int {
            todo.priority = data
            tableView.reloadData()
        }
        
        if let data = notification.userInfo?["tag"] as? String {
            todo.tag = data
            tableView.reloadData()
        }
    }
    
    // MARK: - Helpers
    
    func addTapGesture() {
        view.addGestureRecognizer(tapGesture)
    }
    
    func removeGesture() {
        view.removeGestureRecognizer(tapGesture)
    }
    
    private func postNotification(name: String, userInfo: [String: Any]?) {
        NotificationCenter.default.post(name: NSNotification.Name(name),
                                        object: nil,
                                        userInfo: userInfo)
    }
    
    private func notiAddObserver(name: String) {
        NotificationCenter.default.addObserver(self,
                                               selector: #selector(receivedNotification(notification:)),
                                               name: NSNotification.Name(name),
                                               object: nil)
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
    
    func textFieldShouldBeginEditing(_ textField: UITextField) -> Bool {
        addTapGesture()
        return true
    }
    
    func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool {
        guard let input = textField.text else { return false }
        
        let text = (input as NSString).replacingCharacters(in: range, with: string)
        
        if text.isEmpty {
            addButton.isEnabled = false
        } else {
            addButton.isEnabled = true
        }
        
        todoRepo.updateTitle(todo, title: text)
        return true
    }
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        view.endEditing(true)
        removeGesture()
        return true
    }
}

// MARK: - TextView

extension NewTodoController: UITextViewDelegate {

    func textViewShouldBeginEditing(_ textView: UITextView) -> Bool {
        addTapGesture()
        return true
    }

    func textViewDidBeginEditing(_ textView: UITextView) {
        if textView.text == "텍스트를 여기에 입력하세요." {
            textView.text = nil
            textView.textColor = .white
        }
    }

    func textViewDidEndEditing(_ textView: UITextView) {
        guard let text = textView.text else { return }
        if text.trimmingCharacters(in: .whitespacesAndNewlines).isEmpty {
            textView.text = "텍스트를 여기에 입력하세요."
            textView.textColor = .lightText
        }

        let result = text == "텍스트를 여기에 입력하세요." ? "" : text
        
        // MARK: - 추가버튼 누를때 여기가 한번 더 실행되서 transaction문제 발생. write구문 안에 넣어서 보장하기
        todoRepo.updateMemo(todo, memo: result)
    }
}


// MARK: - TableView

extension NewTodoController: UITableViewDelegate, UITableViewDataSource, EndDateDelegate {
    //endDate업데이트
    func setDate(date: Date?) {
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
        guard let cell = tableView.dequeueReusableCell(withIdentifier: TextCell.identifier) as? TextCell else {
            return UITableViewCell()
        }
        
        switch InputSection.allCases[indexPath.section] {
        case .input:
            guard let cell = tableView.dequeueReusableCell(withIdentifier: InputHeaderCell.identifier, for: indexPath) as? InputHeaderCell else {
                return UITableViewCell()
            }
            cell.titleTextField.delegate = self
            cell.memoTextView.delegate = self
            return cell
        case .endDate:
            let dateManager = DateFormatterManager.shared
            cell.configureCell(title: InputSection.allCases[indexPath.section].title,
                               value: dateManager.dateToString(todo.endDate, format: .dateAndHour))
            
            return cell
        case .tag:
            cell.configureCell(title: InputSection.allCases[indexPath.section].title, value: todo.tag)
            return cell
        case .priority:
            if let priority = todo.priority {
                cell.configureCell(title: InputSection.allCases[indexPath.section].title,
                                   value: Priority.allCases[priority].title)
            } else {
                cell.configureCell(title: InputSection.allCases[indexPath.section].title, value: nil)
            }
            return cell
        case .addImage:
            cell.configureCell(title: InputSection.allCases[indexPath.section].title, value: "")
            return cell
        }
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        switch InputSection.allCases[indexPath.section] {
        case .input:
            break
        case .endDate:
            //delegate
            let vc = EndDateViewController()
            vc.delegate = self
            navigationController?.pushViewController(vc, animated: true)
        case .tag:
            //closure
            let vc = TagViewController()
            navigationController?.pushViewController(vc, animated: true)
        case .priority:
            //notificationCenter
            let vc = PriorityViewController()
            navigationController?.pushViewController(vc, animated: true)
        case .addImage:
            let vc = AddImageViewController()
            navigationController?.pushViewController(vc, animated: true)
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
