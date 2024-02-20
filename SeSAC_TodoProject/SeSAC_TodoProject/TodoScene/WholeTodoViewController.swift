//
//  WholeTodoViewController.swift
//  SeSAC_TodoProject
//
//  Created by Deokhun KIM on 2/14/24.
//

import UIKit

import RealmSwift
import SnapKit

final class WholeTodoViewController: BaseViewController {
    
    // MARK: - Properties
    
    private var todoList: Results<Todo>!
    private let todoRepo = TodoRepository()
    private var searchResultList: Results<Todo>!
    private lazy var searchController = UISearchController(searchResultsController: searchResultTableVC)
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
    
    private lazy var addListButton = UIButton().then {
        $0.setTitle("목록 추가", for: .normal)
        $0.setTitleColor(.tintColor, for: .normal)
        $0.addTarget(self,
                     action: #selector(addListButtonTapped),
                     for: .touchUpInside)
    }
    
    private lazy var newTodoButton = UIBarButtonItem(customView: plusButton)
    private lazy var newListButton = UIBarButtonItem(customView: addListButton)
    
    private lazy var todoCollectionView = {
        let layout = UICollectionViewFlowLayout()
        layout.itemSize = .init(width: (UIScreen.main.bounds.width / 2) - 20, height: 80)
        layout.minimumLineSpacing = 20
        layout.minimumInteritemSpacing = 10
        layout.sectionInset = .init(top: 0, left: 10, bottom: 0, right: 10)
        let cv = UICollectionView(frame: .zero, collectionViewLayout: layout)
        cv.register(WholeTodoCell.self, forCellWithReuseIdentifier: WholeTodoCell.identifier)
        cv.delegate = self
        cv.dataSource = self
        return cv
    }()
    
    lazy var searchResultTableVC = UITableViewController().then {
        $0.tableView.delegate = self
        $0.tableView.dataSource = self
        $0.tableView.register(DetailCell.self, forCellReuseIdentifier: DetailCell.identifier)
        $0.tableView.backgroundColor = .black
        $0.tableView.rowHeight = UITableView.automaticDimension
    }
    
//    private lazy var listTableView = UITableView().then {
//        $0.delegate = self
//        $0.dataSource = self
//    }
    
    // MARK: - Lifecycles
    
    override func viewDidLoad() {
        super.viewDidLoad()
        todoList = todoRepo.fetch(type: Todo.self)
        searchResultList = todoRepo.fetch(type: Todo.self)
        configureSearchBar()
        notiAddObserver(name: "추가")
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        navigationController?.navigationBar.prefersLargeTitles = true
        todoCollectionView.reloadData()
    }
    
    // MARK: - Selectors
    
    @objc override func receivedNotification(notification: NSNotification) {
        todoCollectionView.reloadData()
    }
    
    @objc func newTodoButtonTapped() {
        let vc = NewTodoController(isModal: true)
        let nav = UINavigationController(rootViewController: vc)
        navigationController?.present(nav, animated: true)
    }
    
    @objc func calendarButtonTapped() {
        let vc = CalendarViewController()
        navigationController?.pushViewController(vc, animated: true)
    }
    
    @objc func addListButtonTapped() {
        print(#function)
    }
    
    @objc func ellipsisButtonTapped() {
        print(#function)
    }
    
    // MARK: - Helpers
    
    private func configureSearchBar() {
        navigationItem.hidesSearchBarWhenScrolling = false
        navigationItem.searchController = searchController
        searchController.searchBar.placeholder = "할 일을 검색해주세요"
        searchController.hidesNavigationBarDuringPresentation = false
        searchController.searchResultsUpdater = self
        searchController.searchBar.delegate = self
    }
    
    override func configureHierarchy() {
        view.addSubview(todoCollectionView)
    }
    
    override func configureLayout() {
        todoCollectionView.snp.makeConstraints { make in
            make.edges.equalTo(view.safeAreaLayoutGuide)
        }
    }
    
    override func configureView() {
        super.configureView()
        navigationItem.title = "전체"
        navigationController?.navigationBar.largeTitleTextAttributes = [.foregroundColor: UIColor.systemGray]
        navigationController?.isToolbarHidden = false
        
        navigationItem.rightBarButtonItem = UIBarButtonItem(image: UIImage(systemName: "ellipsis.circle"),
                                                            style: .plain,
                                                            target: self,
                                                            action: #selector(ellipsisButtonTapped))
        navigationItem.leftBarButtonItem = UIBarButtonItem(image: UIImage(systemName: "calendar"),
                                                           style: .plain,
                                                           target: self,
                                                           action: #selector(calendarButtonTapped))
        toolbarItems = [newTodoButton, newListButton]
    }
    
    private func getCellCount(idx: Int) -> Int? {
        let count: Int?
        switch TodoSection.allCases[idx] {
        case .today:
            count = todoRepo.fetchToday(type: Todo.self).count
        case .plan:
            count = todoRepo.fetchPlan(type: Todo.self).count
        case .whole:
            count = todoRepo.fetch(type: Todo.self).count
        case .flag:
            count = todoRepo.fetchFlag(type: Todo.self).count
        case .complete:
            count = todoRepo.fetchComplete(type: Todo.self).count
        }
        return count
    }
}

// MARK: - SearchViewController

extension WholeTodoViewController: UISearchResultsUpdating, UISearchBarDelegate {
    
    func updateSearchResults(for searchController: UISearchController) {
        guard let text = searchController.searchBar.text,
              !text.isEmpty else { return }
        searchResultList = todoRepo.fetch(type: Todo.self).where { $0.title.contains(text, options: .caseInsensitive) }
        searchResultTableVC.tableView.reloadData()
    }
    
    func searchBarCancelButtonClicked(_ searchBar: UISearchBar) {
        searchResultList = todoList
        searchResultTableVC.tableView.reloadData()
    }
}

// MARK: - TableView

extension WholeTodoViewController: UITableViewDelegate, UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        searchResultList.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: DetailCell.identifier, for: indexPath) as? DetailCell else {
            return UITableViewCell()
        }
        
        cell.configureCell(data: searchResultList[indexPath.row])
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let vc = NewTodoController(todo: searchResultList[indexPath.row], isModal: false)
        navigationController?.pushViewController(vc, animated: true)
        vc.navigationController?.navigationBar.prefersLargeTitles = false
    }
}

// MARK: - CollectionView

extension WholeTodoViewController: UICollectionViewDelegate, UICollectionViewDataSource {
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        TodoSection.allCases.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: WholeTodoCell.identifier, for: indexPath) as? WholeTodoCell else {
            return UICollectionViewCell()
        }
        
        cell.configureCell(data: TodoSection.allCases[indexPath.item],
                           count: getCellCount(idx: indexPath.item))
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let vc = DetailViewController()
        vc.navigationItem.title = TodoSection.allCases[indexPath.item].title

        switch TodoSection.allCases[indexPath.item] {
        case .today:
            vc.todoList = todoRepo.fetchToday(type: Todo.self)
        case .plan:
            vc.todoList = todoRepo.fetchPlan(type: Todo.self)
        case .whole:
            vc.todoList = todoRepo.fetch(type: Todo.self)
        case .flag:
            vc.todoList = todoRepo.fetchFlag(type: Todo.self)
        case .complete:
            vc.todoList = todoRepo.fetchComplete(type: Todo.self)
        }
        
        navigationController?.pushViewController(vc, animated: true)
    }
}

