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
    
    var todoList: Results<Todo>? {
        didSet {
            tableView.reloadData()
        }
    }
    
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
        let list = try! Realm().objects(Todo.self)
        $0.menu = UIMenu(title: "필터", children: (0..<menus.count).map { idx in
            UIAction(title: menus[idx]) { _ in
                switch menus[idx] {
                case menus[0]:
                    self.todoList = list.sorted(byKeyPath: "endDate", ascending: true)
                case menus[1]:
                    self.todoList = list.sorted(byKeyPath: "title", ascending: true)
                case menus[2]:
                    self.todoList = list.where { $0.priority == 0 }
                default:
                    break
                }
            }
        })
    }
    
    // MARK: - Helpers
    
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

// MARK: - TableView

extension DetailViewController: UITableViewDelegate, UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        todoList?.count ?? 0
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: DetailCell.identifier, for: indexPath) as? DetailCell,
              let list = todoList else {
            return UITableViewCell()
        }
        
        cell.configureCell(data: list[indexPath.row])
        return cell
    }
}
