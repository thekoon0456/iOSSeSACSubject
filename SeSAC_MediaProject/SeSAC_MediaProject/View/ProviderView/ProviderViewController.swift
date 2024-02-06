//
//  ProviderController.swift
//  SeSAC_MediaProject
//
//  Created by Deokhun KIM on 2/6/24.
//

import UIKit
import WebKit

final class ProviderViewController: BaseViewController {
    
    // MARK: - Properties
    
    let id: Int
    
    private let webView = WKWebView()
    
    private let indicator = {
        let indicator = UIActivityIndicatorView()
        indicator.color = .systemGray
        return indicator
    }()

    init(id: Int) {
        self.id = id
        super.init(nibName: nil, bundle: nil)
    }
    
    // MARK: - Lifecycles
    
    override func viewDidLoad() {
        super.viewDidLoad()

        requestProviderLinks()
    }
    
    func requestYoutubeLinks() {
        TMDBURLSessionManager.shared.fetchURLSessionData(api: .youtubeLink(id: id, season: 1),
                                                         type: YoutubeLink.self) { result in
            switch result {
            case .success(let success):
                print(success)
                guard let key = success.results.last?.key else {
                    print(success.results.first?.key)
                    return
                }
                print(key)
                let url = "https://www.youtube.com/watch?v=\(key)"
                DispatchQueue.main.async { [weak self] in
                    guard let self else { return }
                    loadWebView(url: url)
                }

            case .failure(let failure):
                DispatchQueue.main.async { [weak self] in
                    guard let self else { return }
                    errorAlert(title: failure.title,
                               message: failure.description) { [weak self] in
                        guard let self else { return }
                        requestYoutubeLinks()
                    }
                }
            }
        }
    }
    
    func requestProviderLinks() {
        TMDBURLSessionManager.shared.fetchURLSessionData(api: .provider(id: id),
                                                         type: TVProvider.self) { result in
            switch result {
            case .success(let success):
                let result = success.results
                DispatchQueue.main.async { [weak self] in
                    guard let self else { return }
                    if let krLink = result?.kr?.link {
                        loadWebView(url: krLink)
                        return
                    }
                    
                    if let usLink = result?.us?.link {
                        loadWebView(url: usLink)
                        return
                    }
                }
            case .failure(let failure):
                DispatchQueue.main.async { [weak self] in
                    guard let self else { return }
                    errorAlert(title: failure.title,
                               message: failure.description) { [weak self] in
                        guard let self else { return }
                        requestProviderLinks()
                    }
                }
                print(failure.description)
            }
        }
    }
    
    @objc func rightBarButtonTapped() {
        requestYoutubeLinks()
    }
    
    // MARK: - Helpers

    private func loadWebView(url: String?) {
        guard let url = URL(string: url ?? "") else { return }
        let request = URLRequest(url: url)
        
        webView.load(request)
    }
    
    
    override func configureHierarchy() {
        view.addSubviews(webView, indicator)
    }
    
    override func configureLayout() {
        setLayout()
    }
    
    override func configureView() {
        configureNav()
        configureWebView()
    }
}

// MARK: - Configure

extension ProviderViewController {
    
    private func configureNav() {
        navigationItem.title = "자세히 보기"
        navigationItem.rightBarButtonItem = UIBarButtonItem(title: "예고편 보기",
                                                            style: .plain,
                                                            target: self,
                                                            action: #selector(rightBarButtonTapped))
    }
    
    private func configureWebView() {
        webView.navigationDelegate = self
        webView.backgroundColor = .black
    }
    
    private func setLayout() {
        webView.snp.makeConstraints { make in
            make.edges.equalTo(view.safeAreaLayoutGuide)
        }
        
        indicator.snp.makeConstraints { make in
            make.center.equalToSuperview()
            make.size.equalTo(150)
        }
    }
}

// MARK: - Indicator

extension ProviderViewController: WKNavigationDelegate {
    func webView(_ webView: WKWebView, didStartProvisionalNavigation: WKNavigation!) {
        indicator.startAnimating()
    }
    
    func webView(_ webView: WKWebView, didFinish navigation: WKNavigation!) {
        indicator.hidesWhenStopped = true
        indicator.stopAnimating()
    }
}
