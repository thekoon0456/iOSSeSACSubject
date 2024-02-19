//
//  WebViewController.swift
//  SeSAC_TodoProject
//
//  Created by Deokhun KIM on 2/19/24.
//

import UIKit
import WebKit

final class WebViewController: BaseViewController {
    
    // MARK: - Properties
    
    private let webView = WKWebView()
    
    private let indicator = {
        let indicator = UIActivityIndicatorView()
        indicator.color = .systemGray
        return indicator
    }()
    
    // MARK: - Lifecycles
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        loadWebView(urlString: "https://www.google.co.kr")
    }
    
    // MARK: - Helpers
    
    private func loadWebView(urlString: String?) {
        guard let urlString,
              let url = URL(string: urlString)
        else { return }
        
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
        configureWebView()
        view.backgroundColor = .black
        navigationItem.title = title
    }
}

// MARK: - Configure

extension WebViewController {
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

extension WebViewController: WKNavigationDelegate {
    func webView(_ webView: WKWebView, didStartProvisionalNavigation: WKNavigation!) {
        indicator.startAnimating()
    }
    
    func webView(_ webView: WKWebView, didFinish navigation: WKNavigation!) {
        indicator.hidesWhenStopped = true
        indicator.stopAnimating()
    }
}
