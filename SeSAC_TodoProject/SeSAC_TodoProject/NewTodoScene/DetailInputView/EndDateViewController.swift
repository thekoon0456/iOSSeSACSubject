//
//  EndDateViewController.swift
//  SeSAC_TodoProject
//
//  Created by Deokhun KIM on 2/14/24.
//

import UIKit

//값 전달
protocol EndDateDelegate {
    func setDate(date: Date?)
}

final class EndDateViewController: BaseViewController {
    
    // MARK: - Properties
    
    var delegate: EndDateDelegate?
    private let datePicker = UIDatePicker().then {
        $0.preferredDatePickerStyle = .wheels
        $0.locale = Locale(identifier: "ko_kr")
        $0.minimumDate = Date()
    }
    
    // MARK: - Lifecycles
    
    override func viewWillDisappear(_ animated: Bool) {
        delegate?.setDate(date: datePicker.date)
    }
    
    // MARK: - Helpers
    
    override func configureHierarchy() {
        view.addSubview(datePicker)
    }
    
    override func configureLayout() {
        datePicker.snp.makeConstraints { make in
            make.top.equalTo(view.safeAreaLayoutGuide)
            make.horizontalEdges.equalToSuperview()
            make.height.equalTo(200)
        }
    }
    
    override func configureView() {
        super.configureView()
    }
}
