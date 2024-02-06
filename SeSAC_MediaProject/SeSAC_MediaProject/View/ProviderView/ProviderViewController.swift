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
    
    private let id: Int
    private let isDetailView: Bool
    private let webView = WKWebView()
    
    private let indicator = {
        let indicator = UIActivityIndicatorView()
        indicator.color = .systemGray
        return indicator
    }()
    
    // MARK: - Lifecycles
    
    init(id: Int, isDetailView: Bool) {
        self.id = id
        self.isDetailView = isDetailView
        super.init(nibName: nil, bundle: nil)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        if isDetailView {
            requestProviderLinks()
            configureNav(title: "더 보기")
        } else {
            requestYoutubeLinks()
            configureNav(title: "트레일러 보기")
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
        configureWebView()
        view.backgroundColor = .black
    }
}

// MARK: - Request

extension ProviderViewController {
    
    //트레일러 보기
    func requestYoutubeLinks() {
        TMDBURLSessionManager.shared.fetchURLSessionData(api: .youtubeLink(id: id, season: 1),
                                                         type: YoutubeLink.self) { result in
            switch result {
            case .success(let success):
                guard let key = success.results.last?.key,
                      success.results.isEmpty == false
                else {
                    DispatchQueue.main.async { [weak self] in
                        guard let self else { return }
                        errorAlert(title: "영상이 없습니다.",
                                   message: "뒤로 돌아가주세요",
                                   actionTitle: "뒤로 돌아가기") { [weak self] in
                            guard let self else { return }
                            navigationController?.popViewController(animated: true)
                        }
                    }
                    return
                }
                
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
    
    //더 보기
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
                    
                    DispatchQueue.main.async { [weak self] in
                        guard let self else { return }
                        self.errorAlert(title: "더보기 정보가 없습니다.",
                                        message: "뒤로 돌아가주세요",
                                        actionTitle: "뒤로 돌아가기") { [weak self] in
                            guard let self else { return }
                            navigationController?.popViewController(animated: true)
                        }
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
            }
        }
    }
}

// MARK: - Configure

extension ProviderViewController {
    
    private func configureNav(title: String) {
        navigationItem.title = title
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
