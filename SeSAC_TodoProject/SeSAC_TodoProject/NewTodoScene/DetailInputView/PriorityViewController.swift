//
//  PrimaryViewController.swift
//  SeSAC_TodoProject
//
//  Created by Deokhun KIM on 2/14/24.
//

import UIKit

final class PriorityViewController: BaseViewController {
    
    // MARK: - Properties
    let items = Priority.allCases.map { $0.title }
    private lazy var primarySeg = UISegmentedControl(items: items).then {
        $0.selectedSegmentIndex = 1
    }
    
    // MARK: - Lifecycles
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        
        postNotification(name: "우선순위",
                         userInfo: ["우선순위": Priority.allCases[primarySeg.selectedSegmentIndex].rawValue])
    }
    
    deinit {
        NotificationCenter.default.removeObserver(self)
    }
    
    // MARK: - Helpers
    
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
