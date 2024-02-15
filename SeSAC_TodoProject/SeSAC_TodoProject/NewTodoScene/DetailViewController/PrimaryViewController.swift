//
//  PrimaryViewController.swift
//  SeSAC_TodoProject
//
//  Created by Deokhun KIM on 2/14/24.
//

import UIKit

final class PrimaryViewController: BaseViewController {
    
    // MARK: - Properties
    private let items =  ["낮음", "중간", "높음"]
    private lazy var primarySeg = UISegmentedControl(items: items).then {
        $0.selectedSegmentIndex = 0
    }
    
    // MARK: - Lifecycles
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        
        postNotification(name: "우선순위", userInfo: ["우선순위": items[primarySeg.selectedSegmentIndex]])
    }
    
    // MARK: - Helpers
    
    func postNotification(name: String, userInfo: [String: Any]?) {
        NotificationCenter.default.post(name: NSNotification.Name(name),
                                        object: nil,
                                        userInfo: userInfo)
    }
    
    deinit {
        NotificationCenter.default.removeObserver(self)
    }
    
    override func configureHierarchy() {
        view.addSubview(primarySeg)
    }
    
    override func configureLayout() {
        primarySeg.snp.makeConstraints { make in
            make.top.equalTo(view.safeAreaLayoutGuide)
            make.horizontalEdges.equalToSuperview()
            make.height.equalTo(50)
        }
    }
    
    override func configureView() {
        super.configureView()
    }
    
}
