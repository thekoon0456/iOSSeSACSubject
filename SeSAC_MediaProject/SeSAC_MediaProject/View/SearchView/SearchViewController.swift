//
//  SearchViewController.swift
//  SeSAC_MediaProject
//
//  Created by Deokhun KIM on 2/2/24.
//

import UIKit

final class SearchViewController: BaseViewController {
    
    private let searchBar = UISearchBar()
    private let emptyView = UIView()
    private let emptyImageView = UIImageView()
    private let emptyLabel = UILabel()
    private lazy var tabGesture = UITapGestureRecognizer(target: self,
                                                         action: #selector(dismissKeyboard))
    
    private lazy var recentSearchTableView = {
        let tv = UITableView(frame: .zero, style: .plain)
        tv.register(RecentSearchCell.self,
                           forCellReuseIdentifier: RecentSearchCell.identifier)
        tv.tableHeaderView = recentSearchHeaderView
        tv.sectionHeaderHeight = 40
        tv.rowHeight = 50
        tv.separatorStyle = .none
        return tv
    }()
    
    //헤더뷰
    private lazy var recentSearchHeaderView = {
        let frame = CGRect(x: 0,
                           y: 0,
                           width: UIScreen.main.bounds.width,
                           height: 40)
        let headerView = UIView(frame: frame)
        headerView.backgroundColor = .white
        headerView.addSubview(headerTitle)
        headerView.addSubview(deleteAllButton)
        
        return headerView
    }()
    
    //최근 검색
    private lazy var headerTitle = {
        let frame = CGRect(x: 10,
                           y: 5,
                           width: UIScreen.main.bounds.width,
                           height: 30)
        let label = UILabel(frame: frame)
        setLabel(label,
                 text: "검색하기",
                 fontSize: 15,
                 color: UIColor.label)
        return label
    }()
    
    //모두 지우기 버튼
    private let deleteAllButton = {
        let frame = CGRect(x: UIScreen.main.bounds.width - 100,
                           y: 5,
                           width: 100,
                           height: 30)
        let button = UIButton(frame: frame)
        button.setTitle("모두 지우기",
                        for: .normal)
        button.titleLabel?.font = .boldSystemFont(ofSize: 13)
        button.setTitleColor(.label, for: .normal)
        return button
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        
    }
    
    // MARK: - Selectors
    
    @objc private func dismissKeyboard() {
        view.endEditing(true)
        view.removeGestureRecognizer(tabGesture)
    }
    
    // MARK: - Helpers
    
    override func configureHierarchy() {
        view.addSubviews(searchBar, recentSearchTableView, emptyView)
        emptyView.addSubviews(emptyImageView, emptyLabel)
    }
    
    override func configureLayout() {
        setLayout()
    }
    
    override func configureView() {
        view.backgroundColor = .white
        configureNav()
        configureSearchBar()
        configureEmptyView()
    }
}

// MARK: - SearchBar

extension SearchViewController: UISearchBarDelegate {
    //
    //    //textField 입력 시작할때 dismiss제스처 달기
    //    func searchBarTextDidBeginEditing(_ searchBar: UISearchBar) {
    //        view.addGestureRecognizer(tabGesture)
    //    }
    //
    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
        
        TMDBAPIManager.shared.fetchData(api: .search(text: searchBar.text!, page: 1), type: TV.self) { tv in
            let vc = DramaViewController()
            vc.requestDramaData(id: tv.results.first?.id)
            self.navigationController?.pushViewController(vc, animated: true)
        }
    }
}

////        guard var list = viewModel.currentUserValue?.searchResults,
//        guard let searchText = searchBar.text
//        else { return }
//        
//        //소문자로 바꿔 저장, whitespace 다듬기
//        let inputText = searchText.lowercased().trimmingCharacters(in: .whitespaces)
//        
//        //list에 기존 검색어를 가지고 있으면 list의 가장 위로 올려줌
//        if list.contains(where: { $0 == inputText }) {
//            guard let index = list.firstIndex(of: inputText) else { return }
//            list.remove(at: index)
//        }
//        
//        //최근 검색 list에 추가
//        list.insert(inputText, at: 0)
//        viewModel.updateUserSearchResults(input: list)
//        
//        //화면이동
//        viewModel.pushSearchResult(data: inputText)
//        
//        //textField 초기화
//        dismissKeyboard()
//        searchBar.text = nil
//    }
//}

// MARK: - Configure

extension SearchViewController {
    
    private func configureNav() {
        navigationItem.title = ("검색하기")
        navigationItem.backButtonDisplayMode = .minimal
    }
    
    private func configureSearchBar() {
        searchBar.delegate = self
        searchBar.searchTextField.backgroundColor = .white
        searchBar.barTintColor = .white
        searchBar.tintColor = .white
        searchBar.placeholder = "검색해주세요"
    }
    
    private func configureEmptyView() {
        emptyView.isHidden = true
        emptyView.backgroundColor = .clear
        emptyImageView.image = UIImage(systemName: "xmark")
        emptyImageView.contentMode = .scaleAspectFill
        setLabel(emptyLabel,
                 text: "TV프로그램을 입력해주세요.",
                 fontSize: 16,
                 isBold: true,
                 color: .label,
                 alignment: .center)
    }
    
    private func setLayout() {
        searchBar.snp.makeConstraints { make in
            make.top.leading.trailing.equalTo(view.safeAreaLayoutGuide)
        }
        
        recentSearchTableView.snp.makeConstraints { make in
            make.top.equalTo(searchBar.snp.bottom)
            make.horizontalEdges.bottom.equalTo(view.safeAreaLayoutGuide)
        }
        
        emptyView.snp.makeConstraints { make in
            make.top.equalTo(searchBar.snp.bottom)
            make.horizontalEdges.bottom.equalTo(view.safeAreaLayoutGuide)
        }
        
        emptyImageView.snp.makeConstraints { make in
            make.center.equalToSuperview()
            make.leading.equalToSuperview().offset(16)
            make.trailing.equalToSuperview().offset(-16)
            make.height.equalTo(emptyView.snp.width).multipliedBy(0.5)
        }
        
        emptyLabel.snp.makeConstraints { make in
            make.top.equalTo(emptyImageView.snp.bottom).offset(32)
            make.centerX.equalToSuperview()
        }
    }
}
