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
    
    private lazy var plusButton = UIButton().then {
        let image = UIImage(systemName: "plus.circle.fill")?.applyingSymbolConfiguration(.init(font: .boldSystemFont(ofSize: 24)))
        $0.setImage(image, for: .normal)
        $0.setTitle("새로운 할 일", for: .normal)
        $0.setTitleColor(.tintColor, for: .normal)
        $0.imageEdgeInsets = .init(top: 0, left: -8, bottom: 0, right: 8)
        $0.addTarget(self, action: #selector(newTodoButtonTapped), for: .touchUpInside)
    }
    
    private lazy var addListButton = UIButton().then {
        $0.setTitle("목록 추가", for: .normal)
        $0.setTitleColor(.tintColor, for: .normal)
        $0.addTarget(self, action: #selector(addListButtonTapped), for: .touchUpInside)
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
    
    // MARK: - Lifecycles
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        todoList = todoRepo.fetch(type: Todo.self)
        notiAddObserver(name: "추가")
        //        todoRepo.printURL()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        todoCollectionView.reloadData()
    }
    
    // MARK: - Selectors
    
    @objc override func receivedNotification(notification: NSNotification) {
        todoCollectionView.reloadData()
    }
    
    @objc func newTodoButtonTapped() {
        let vc = NewTodoController()
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
        navigationController?.navigationBar.prefersLargeTitles = true
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
    
    private func getCount(idx: Int) -> Int? {
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
                           count: getCount(idx: indexPath.item))
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

