//
//  DetailViewController.swift
//  SeSAC_TodoProject
//
//  Created by Deokhun KIM on 2/15/24.
//

import UIKit

import SnapKit

final class DetailViewController: BaseViewController {
    
    // MARK: - Properties
    
    let todoRepo = TodoRepository()
    var list: [Todo] {
        didSet {
            tableView.reloadData()
        }
    }
    
    init(list: [Todo]) {
        self.list = list
        super.init()
    }
    
    private lazy var plusButton = UIButton().then {
        let image = UIImage(systemName: "plus.circle.fill")?.applyingSymbolConfiguration(.init(font: .boldSystemFont(ofSize: 24)))
        $0.setImage(image, for: .normal)
        $0.setTitle("새로운 할 일", for: .normal)
        $0.setTitleColor(.tintColor, for: .normal)
        $0.imageEdgeInsets = .init(top: 0, left: -8, bottom: 0, right: 8)
        $0.addTarget(self,
                     action: #selector(newTodoButtonTapped),
                     for: .touchUpInside)
    }
    
    private lazy var newTodoButton = UIBarButtonItem(customView: plusButton)
    
    lazy var tableView = UITableView().then {
        $0.delegate = self
        $0.dataSource = self
        $0.register(DetailCell.self, forCellReuseIdentifier: DetailCell.identifier)
        $0.backgroundColor = .clear
        $0.rowHeight = UITableView.automaticDimension
    }
    
    private lazy var ellipsisButton = UIButton().then {
        let image = UIImage(systemName: "ellipsis.circle")?.applyingSymbolConfiguration(.init(font: .systemFont(ofSize: 20)))
        $0.setImage(image, for: .normal)
        $0.showsMenuAsPrimaryAction = true
        
        let menus = ["마감일 순으로 보기", "제목 순으로 보기", "우선순위 낮음만 보기"]
        $0.menu = UIMenu(title: "필터", children: (0..<menus.count).map { idx in
            UIAction(title: menus[idx]) { [weak self] _ in
                guard let self else { return }
                switch menus[idx] {
                case menus[0]:
                    list = Array(todoRepo.fetchEndDate())
                case menus[1]:
                    list = Array(todoRepo.fetchTitle())
                case menus[2]:
                    list = Array(todoRepo.fetchLowPriority())
                default:
                    break
                }
            }
        })
    }
    
    // MARK: - Lifecycles
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        tableView.reloadData()
    }
    
    // MARK: - Selectors
    
    @objc func newTodoButtonTapped() {
        let vc = NewTodoController(main: nil, isModal: true)
        vc.dismissView = {
            self.viewWillAppear(true)
        }
        let nav = UINavigationController(rootViewController: vc)
        navigationController?.present(nav, animated: true)
    }
    
    @objc func completeButtonTapped(sender: UIButton) {
        sender.isSelected.toggle()
        sender.tintColor = sender.isSelected ? .systemYellow : .white
        
        todoRepo.updateComplete(todoRepo.list[sender.tag])
    }
    
    // MARK: - Helpers
    
    private func configureCompleteButton(button: UIButton, tag: Int) {
        button.tag = tag
        button.tintColor = button.isSelected ? .systemYellow : .white
        button.addTarget(self,
                         action: #selector(completeButtonTapped),
                         for: .touchUpInside)
    }
    
    override func configureHierarchy() {
        view.addSubview(tableView)
    }
    
    override func configureLayout() {
        tableView.snp.makeConstraints { make in
            make.edges.equalTo(view.safeAreaLayoutGuide)
        }
    }
    
    override func configureView() {
        super.configureView()
        navigationController?.navigationBar.prefersLargeTitles = false
        navigationItem.rightBarButtonItem = UIBarButtonItem(customView: ellipsisButton)
        

        if navigationController?.isToolbarHidden == false {
            toolbarItems = [newTodoButton, UIBarButtonItem()]
        }
    }
}

// MARK: - TableView

extension DetailViewController: UITableViewDelegate, UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        list.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: DetailCell.identifier, for: indexPath) as? DetailCell else {
            return UITableViewCell()
        }
        
        cell.configureCell(data: list[indexPath.row])
        configureCompleteButton(button: cell.completeButton, tag: indexPath.row)
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let vc = NewTodoController(todo: list[indexPath.row], main: nil, isModal: false)
        navigationController?.pushViewController(vc, animated: true)
    }
    
    // MARK: - Delete
    
    func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
        true
    }
    
    func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            todoRepo.delete(list[indexPath.row])
            tableView.reloadData()
        }
    }
    
    // MARK: - leading
    
    func tableView(_ tableView: UITableView, leadingSwipeActionsConfigurationForRowAt indexPath: IndexPath) -> UISwipeActionsConfiguration? {
        let flag = UIContextualAction(style: .normal,
                                      title: "Flag") { [weak self] action, view, completion in
            guard let self else { return }
            todoRepo.updateFlag(list[indexPath.row])
            tableView.reloadData()
            completion(true)
        }
        
        let imageName = list[indexPath.row].isFlag ? "flag.fill" : "flag"
        flag.image = UIImage(systemName: imageName)
        flag.backgroundColor = .systemOrange
        
        return UISwipeActionsConfiguration(actions: [flag])
    }
}
