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
        
        request()
    }
    
    func request() {
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
                        request()
                    }
                }
                print(failure.description)
            }
        }
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
