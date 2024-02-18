//
//  DetailViewController.swift
//  SeSAC_TodoProject
//
//  Created by Deokhun KIM on 2/15/24.
//

import UIKit

import RealmSwift
import SnapKit

final class DetailViewController: BaseViewController {
    
    // MARK: - Properties
    private let todoRepo = TodoRepository()
    var todoList: Results<Todo>!
    var filteredList: Results<Todo>!
    
    let searchController = UISearchController(searchResultsController: nil)
    private lazy var tableView = UITableView().then {
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
        guard let list = todoList else { return }
        $0.menu = UIMenu(title: "필터", children: (0..<menus.count).map { idx in
            UIAction(title: menus[idx]) { _ in
                switch menus[idx] {
                case menus[0]:
                    self.todoList = list.sorted(byKeyPath: "endDate", ascending: true)
                    self.tableView.reloadData()
                case menus[1]:
                    self.todoList = list.sorted(byKeyPath: "title", ascending: true)
                    self.tableView.reloadData()
                case menus[2]:
                    self.todoList = list.where { $0.priority == 0 }
                    self.tableView.reloadData()
                default:
                    break
                }
            }
        })
    }
    
    // MARK: - Lifecycles
    
    override func viewDidLoad() {
        super.viewDidLoad()
        filteredList = todoList
        configureSearchBar()
    }
    
    // MARK: - Selectors
    
    @objc func completeButtonTapped(sender: UIButton) {
        sender.isSelected.toggle()
        sender.tintColor = sender.isSelected ? .systemYellow : .white
        todoRepo.updateComplete(todoList[sender.tag])
    }
    
    // MARK: - Helpers
    
    private func configureSearchBar() {
        navigationItem.searchController = searchController
        navigationItem.hidesSearchBarWhenScrolling = false
        searchController.searchBar.placeholder = "할 일을 검색해주세요"
        searchController.hidesNavigationBarDuringPresentation = false
        searchController.searchResultsUpdater = self
        searchController.searchBar.delegate = self
    }
    
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
        navigationItem.rightBarButtonItem = UIBarButtonItem(customView: ellipsisButton)
        view.backgroundColor = .black
    }
    
}

// MARK: - SearchViewController

extension DetailViewController: UISearchResultsUpdating, UISearchBarDelegate {
    
    func updateSearchResults(for searchController: UISearchController) {
        guard let text = searchController.searchBar.text,
              !text.isEmpty else { return }
        filteredList = todoRepo.fetch(type: Todo.self).where { $0.title.contains(text, options: .caseInsensitive) }
        tableView.reloadData()
    }
    
    func searchBarCancelButtonClicked(_ searchBar: UISearchBar) {
        filteredList = todoList
        tableView.reloadData()
    }
}

// MARK: - TableView

extension DetailViewController: UITableViewDelegate, UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        filteredList?.count ?? 0
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: DetailCell.identifier, for: indexPath) as? DetailCell,
              let list = filteredList else {
            return UITableViewCell()
        }
        cell.configureCell(data: list[indexPath.row])
        configureCompleteButton(button: cell.completeButton, tag: indexPath.row)
        return cell
    }
    
    // MARK: - Delete
    
    func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
        true
    }
    
    func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            todoRepo.delete(filteredList[indexPath.row])
            tableView.reloadData()
        }
    }
    
    // MARK: - leading
    
    func tableView(_ tableView: UITableView, leadingSwipeActionsConfigurationForRowAt indexPath: IndexPath) -> UISwipeActionsConfiguration? {
        let flag = UIContextualAction(style: .normal,
                                      title: "Flag") { action, view, completion in
            self.todoRepo.updateFlag(self.filteredList[indexPath.row])
            completion(true)
        }
        
        let imageName = self.filteredList[indexPath.row].isFlag ? "flag.fill" : "flag"
        flag.image = UIImage(systemName: imageName)
        flag.backgroundColor = .systemOrange
        
        return UISwipeActionsConfiguration(actions: [flag])
    }
}
