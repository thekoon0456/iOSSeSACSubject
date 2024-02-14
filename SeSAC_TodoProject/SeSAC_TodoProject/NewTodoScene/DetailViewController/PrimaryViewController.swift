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
        
        postNoti()
    }
    
    // MARK: - Helpers
    
    func postNoti() {
        NotificationCenter.default.post(name: NSNotification.Name("우선순위"),
                                        object: nil,
                                        userInfo: ["우선순위": items[primarySeg.selectedSegmentIndex]])
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
