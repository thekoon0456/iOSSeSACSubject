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
        
        todoList = setRealm(type: Todo.self)
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        print(todoList)
    }
    
    // MARK: - Selectors
    
    @objc func newTodoButtonTapped() {
        print(#function)
        let vc = NewTodoController()
        let nav = UINavigationController(rootViewController: vc)
        
        navigationController?.present(nav, animated: true)
    }
    
    @objc func addListButtonTapped() {
        print(#function)
    }
    
    @objc func ellipsisButtonTapped() {
        print(#function)
    }
    
    // MARK: - Helpers
    
    func setRealm<T: Object>(type: T.Type) -> Results<T> {
        let realm = try! Realm()
        return realm.objects(type.self)
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
        navigationController?.navigationBar.prefersLargeTitles = true
        navigationController?.isToolbarHidden = false
        
        navigationItem.rightBarButtonItem = UIBarButtonItem(image: UIImage(systemName: "ellipsis.circle"),
                                                            style: .plain,
                                                            target: self,
                                                            action: #selector(ellipsisButtonTapped))
        toolbarItems = [newTodoButton, newListButton]
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
        
        cell.configureCell(data: TodoSection.allCases[indexPath.item])
        return cell
    }
}
