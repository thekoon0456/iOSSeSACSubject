//
//  SearchViewController.swift
//  SeSAC_MediaProject
//
//  Created by Deokhun KIM on 2/2/24.
//

import UIKit

final class SearchViewController: BaseViewController {
    
    private let searchBar = UISearchBar()
    private let tableView = UITableView()
    
    private lazy var tabGesture = UITapGestureRecognizer(target: self,
                                                         action: #selector(dismissKeyboard))
    
    private lazy var recentSearchTableView = {
        let tv = UITableView(frame: .zero, style: .plain)
        tv.register(SearchResultCell.self,
                           forCellReuseIdentifier: SearchResultCell.identifier)
        tv.sectionHeaderHeight = 40
        tv.rowHeight = 50
        tv.separatorStyle = .none
        tv.backgroundColor = .clear
        return tv
    }()
    
    var list: [TVModel] = [] {
        didSet {
            tableView.reloadData()
        }
    }
    
    // MARK: - Selectors
    
    @objc private func dismissKeyboard() {
        view.endEditing(true)
        view.removeGestureRecognizer(tabGesture)
    }
    
    // MARK: - Helpers
    
    override func configureHierarchy() {
        view.addSubviews(searchBar, tableView)
    }
    
    override func configureLayout() {
        setLayout()
    }
    
    override func configureView() {
        view.backgroundColor = .black
        configureNav()
        configureSearchBar()
        tableView.backgroundColor = .clear
        tableView.delegate = self
        tableView.dataSource = self
        tableView.register(SearchResultCell.self, forCellReuseIdentifier: SearchResultCell.identifier)
    }
}

// MARK: - SearchBar

extension SearchViewController: UISearchBarDelegate {
       
    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
        guard let searchText = searchBar.text else { return }
        //소문자로 바꾸고, whitespace 다듬기
        let inputText = searchText.lowercased().trimmingCharacters(in: .whitespaces)
        
        //엔터치면 첫번째 게시물 보여줌
        TMDBAPIManager.shared.fetchData(api: .search(text: inputText, page: 1), type: TV.self) { tv in
            let vc = DramaViewController()
            vc.navigationItem.title = searchBar.text!
            vc.requestDramaData(id: tv.results.first?.id)
            self.navigationController?.pushViewController(vc, animated: true)
        }
        
        dismissKeyboard()
        searchBar.text = nil
    }
    
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        guard let searchText = searchBar.text else { return }
        //소문자로 바꾸고, whitespace 다듬기
        let inputText = searchText.lowercased().trimmingCharacters(in: .whitespaces)
        
        TMDBAPIManager.shared.fetchData(api: .search(text: inputText, page: 1), type: TV.self) { tv in
            self.list = tv.results
        }
    }
}

// MARK: - Configure

extension SearchViewController {
    
    private func configureNav() {
        navigationItem.title = ("검색하기")
        navigationItem.backButtonDisplayMode = .minimal
    }
    
    private func configureSearchBar() {
        searchBar.delegate = self
        searchBar.barStyle = .black
        searchBar.barTintColor = .black
        searchBar.tintColor = .white
        searchBar.searchTextField.backgroundColor = .secondarySystemBackground
        searchBar.searchTextField.textColor = .white
        searchBar.placeholder = "검색해주세요"
    }
    
    private func setLayout() {
        searchBar.snp.makeConstraints { make in
            make.top.leading.trailing.equalTo(view.safeAreaLayoutGuide)
        }
        
        tableView.snp.makeConstraints { make in
            make.top.equalTo(searchBar.snp.bottom)
            make.horizontalEdges.bottom.equalTo(view.safeAreaLayoutGuide)
        }
    }
}

// MARK: - TableView

extension SearchViewController: UITableViewDataSource, UITableViewDelegate {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        list.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: SearchResultCell.identifier, for: indexPath) as? SearchResultCell
        else { return UITableViewCell() }
        
        cell.configureCellData(list[indexPath.item])
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let vc = DramaViewController()
        vc.requestDramaData(id: list[indexPath.item].id)
        self.navigationController?.pushViewController(vc, animated: true)
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        200
    }
}
