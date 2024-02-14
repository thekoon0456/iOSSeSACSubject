//
//  EndDateViewController.swift
//  SeSAC_TodoProject
//
//  Created by Deokhun KIM on 2/14/24.
//

import UIKit

protocol EndDateDelegate {
    func setDate(date: String)
}

final class EndDateViewController: BaseViewController {
    
    // MARK: - Properties
    
    private let datePicker = UIDatePicker().then {
        $0.preferredDatePickerStyle = .wheels
        $0.locale = Locale(identifier: "ko_kr")
    }
    
    var delegate: EndDateDelegate?
    
    // MARK: - Lifecycles
    
    override func viewWillDisappear(_ animated: Bool) {
        delegate?.setDate(date: getDateString(datePicker.date))
    }
    
    // MARK: - Helpers
    
    private func getDateString(_ date: Date) -> String {
        let formatter = DateFormatter()
        formatter.locale = Locale(identifier: "ko_kr")
        formatter.timeZone = TimeZone(abbreviation: "KST")
        formatter.dateFormat = "yyyy년 M월 d일 a hh:mm"
        return formatter.string(from: date)
    }
    
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
