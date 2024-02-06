//
//  SearchViewController.swift
//  SeSAC_MediaProject
//
//  Created by Deokhun KIM on 2/2/24.
//

import UIKit

final class SearchViewController: BaseViewController {
    
    // MARK: - Properties
    
    private let throttle = ThrottleManager()
    
    private lazy var searchBar = UISearchBar().then {
        $0.delegate = self
        $0.barStyle = .black
        $0.barTintColor = .black
        $0.tintColor = .white
        $0.searchTextField.backgroundColor = .secondarySystemBackground
        $0.searchTextField.textColor = .white
        $0.placeholder = "검색해주세요"
    }
    
    private lazy var tableView = UITableView().then {
        $0.backgroundColor = .clear
        $0.delegate = self
        $0.dataSource = self
        $0.register(SearchResultCell.self, forCellReuseIdentifier: SearchResultCell.identifier)
    }
    
    private lazy var tabGesture = UITapGestureRecognizer(target: self,
                                                         action: #selector(dismissKeyboard))
    
    var list: [TVModel] = [] {
        didSet {
            tableView.reloadData()
        }
    }
    
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
        navigationItem.title = ("검색하기")
        navigationItem.backButtonDisplayMode = .minimal
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
        throttle.execute(timeInterval: 0.5) {
            guard let searchText = searchBar.text else { return }
            let inputText = searchText.lowercased().trimmingCharacters(in: .whitespaces)
            
            TMDBAPIManager.shared.fetchData(api: .search(text: inputText, page: 1), type: TV.self) { tv in
                print("요청: \(inputText)")
                self.list = tv.results
            }
        }
    }
}

// MARK: - Configure

extension SearchViewController {
    
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
