//
//  MagazineWebViewController.swift
//  SeSAC_TableAndCollectionView
//
//  Created by Deokhun KIM on 1/15/24.
//

import UIKit
import WebKit

class MagazineWebViewController: UIViewController {
    
    @IBOutlet var webView: WKWebView!

    override func viewDidLoad() {
        super.viewDidLoad()
        
    }
}

// MARK: - UI

extension MagazineWebViewController: SetUI {
    func setData(_ data: Magazine) {
        navigationItem.title = data.title
        setWebView(urlString: data.link)
    }
    
    func setWebView(urlString: String) {
        guard let url = URL(string: urlString) else { return }
        let urlRequest = URLRequest(url: url)
        
        DispatchQueue.main.async {
            self.webView.load(urlRequest)
        }
    }
    
    func configureUI() { }
}
