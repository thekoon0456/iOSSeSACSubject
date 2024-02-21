//
//  WholeTodoViewController.swift
//  SeSAC_TodoProject
//
//  Created by Deokhun KIM on 2/14/24.
//

import UIKit

import SnapKit

final class WholeTodoViewController: BaseViewController {
    
    // MARK: - Properties
    //import realmSwift는 repository에서만!
    //필터를 뷰에서X, repository에서 하고 뷰는 받기만 함
    private let todoRepo = TodoRepository()
    private let todoListSectionRepo = TodoListSectionRepository()
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
    
    private lazy var listTableView = UITableView(frame: .zero, style: .insetGrouped).then {
        $0.delegate = self
        $0.dataSource = self
        $0.register(UITableViewCell.self, forCellReuseIdentifier: "UITableViewCell")
    }
    
    // MARK: - Lifecycles
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        configureSearchBar()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        navigationController?.navigationBar.prefersLargeTitles = true
        navigationController?.isToolbarHidden = false
        listTableView.reloadData()
        todoCollectionView.reloadData()
    }
    
    // MARK: - Selectors
    
    @objc override func receivedNotification(notification: NSNotification) {
        todoCollectionView.reloadData()
    }
    
    @objc func newTodoButtonTapped() {
        let vc = NewTodoController(main: nil, isModal: true)
        vc.dismissView = {
            self.viewWillAppear(true)
        }
        let nav = UINavigationController(rootViewController: vc)
        navigationController?.present(nav, animated: true)
    }
    
    @objc func calendarButtonTapped() {
        let vc = CalendarViewController()
        navigationController?.pushViewController(vc, animated: true)
    }
    
    @objc func addListButtonTapped() {
        print(#function)
        let vc = NewListViewController()
        vc.dismissView = {
            self.viewWillAppear(true)
        }
        let nav = UINavigationController(rootViewController: vc)
        navigationController?.present(nav, animated: true)
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
        view.addSubviews(todoCollectionView, listTableView)
    }
    
    override func configureLayout() {
        todoCollectionView.snp.makeConstraints { make in
            make.top.horizontalEdges.equalTo(view.safeAreaLayoutGuide)
            make.height.equalTo(view.safeAreaLayoutGuide).multipliedBy(0.5)
        }
        
        listTableView.snp.makeConstraints { make in
            make.top.equalTo(todoCollectionView.snp.bottom)
            make.leading.trailing.bottom.equalTo(view.safeAreaLayoutGuide)
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
}

// MARK: - SearchViewController

extension WholeTodoViewController: UISearchResultsUpdating, UISearchBarDelegate {
    
    func updateSearchResults(for searchController: UISearchController) {
        guard let text = searchController.searchBar.text,
              !text.isEmpty else { return }
        todoRepo.fetchSearch(title: text)
        searchResultTableVC.tableView.reloadData()
    }
    
    func searchBarCancelButtonClicked(_ searchBar: UISearchBar) {
        todoRepo.fetchSearchReset()
        searchResultTableVC.tableView.reloadData()
    }
}

// MARK: - TableView

extension WholeTodoViewController: UITableViewDelegate, UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        if tableView == listTableView {
            let titleLabel = UILabel().then {
                $0.text = "목록"
                $0.font = .boldSystemFont(ofSize: 30)
                $0.textColor = .lightGray
            }
            return titleLabel
        } else {
            return nil
        }
    }
    
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        if tableView == listTableView {
            return 48
        } else {
            return 0
        }
    }
    
    func numberOfSections(in tableView: UITableView) -> Int {
        1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if tableView == listTableView {
            todoListSectionRepo.list.count
        } else {
            todoRepo.fetchCurrentFilteredList().count
        }
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if tableView == listTableView {
            guard let cell = tableView.dequeueReusableCell(withIdentifier: "UITableViewCell") else { return UITableViewCell() }
            //TODO: -CustomCell로 변환
            cell.accessoryType = .disclosureIndicator
            cell.imageView?.image = UIImage(systemName: "list.bullet")?.withTintColor(.white).withRenderingMode(.alwaysOriginal)
            cell.textLabel?.text = todoListSectionRepo.list[indexPath.row].todoListTitle
            cell.detailTextLabel?.text = String(todoListSectionRepo.list[indexPath.row].todo.count)
            return cell
        } else {
            guard let cell = tableView.dequeueReusableCell(withIdentifier: DetailCell.identifier, for: indexPath) as? DetailCell else { return UITableViewCell() }
            cell.configureCell(data: todoRepo.filteredList[indexPath.row])
            return cell
        }
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        if tableView == listTableView {
            let vc = DetailTodoListViewController()
            vc.index = indexPath.row
            navigationController?.isToolbarHidden = false
            navigationController?.pushViewController(vc, animated: true)
            vc.navigationController?.navigationBar.prefersLargeTitles = true
        } else {
            let vc = NewTodoController(todo: todoRepo.filteredList[indexPath.row], main: nil, isModal: false)
            navigationController?.pushViewController(vc, animated: true)
            vc.navigationController?.navigationBar.prefersLargeTitles = false
        }
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
                           count: todoRepo.getCellCount(idx: indexPath.item))
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let vc = DetailViewController()
        vc.navigationItem.title = TodoSection.allCases[indexPath.item].title

        switch TodoSection.allCases[indexPath.item] {
        case .today:
            vc.todoRepo.filteredList = todoRepo.fetchToday()
        case .plan:
            vc.todoRepo.filteredList = todoRepo.fetchPlan()
        case .whole:
            vc.todoRepo.filteredList = todoRepo.fetch()
        case .flag:
            vc.todoRepo.filteredList = todoRepo.fetchFlag()
        case .complete:
            vc.todoRepo.filteredList = todoRepo.fetchComplete()
        }
        
        navigationController?.isToolbarHidden = true
        navigationController?.pushViewController(vc, animated: true)
    }
}

