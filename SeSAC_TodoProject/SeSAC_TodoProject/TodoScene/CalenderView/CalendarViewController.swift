//
//  CalanderViewController.swift
//  SeSAC_TodoProject
//
//  Created by Deokhun KIM on 2/19/24.
//

import UIKit

import FSCalendar
import RealmSwift
import SnapKit

final class CalendarViewController: BaseViewController {
    
    // MARK: - Properties
    
    private let todoRepo = TodoRepository()
    private var list: Results<Todo>!
    private lazy var calendar = FSCalendar().then {
        $0.delegate = self
        $0.dataSource = self
        $0.locale = Locale(identifier: "ko_KR")
        $0.appearance.titleDefaultColor = .label
        $0.appearance.eventDefaultColor = .label
        $0.appearance.headerTitleColor = .label
        $0.appearance.titleWeekendColor = .label
        $0.appearance.weekdayTextColor = .label
        $0.appearance.selectionColor = .systemRed
        $0.appearance.todaySelectionColor = .systemBlue
    }
    private lazy var tableView = UITableView().then {
        $0.delegate = self
        $0.dataSource = self
        $0.register(DetailCell.self, forCellReuseIdentifier: DetailCell.identifier)
    }
    
    // MARK: - Lifecycles
    
    override func viewDidLoad() {
        super.viewDidLoad()
        list = todoRepo.fetch(type: Todo.self)
    }
    
    // MARK: - Helpers
    
    override func configureHierarchy() {
        view.addSubviews(calendar, tableView)
    }
    
    override func configureLayout() {
        calendar.snp.makeConstraints { make in
            make.top.horizontalEdges.equalToSuperview()
            make.height.equalTo(300)
        }
        
        tableView.snp.makeConstraints { make in
            make.top.equalTo(calendar.snp.bottom)
            make.horizontalEdges.bottom.equalToSuperview()
        }
    }
    
    override func configureView() {
        super.configureView()
        
    }
}

// MARK: - Calendar

extension CalendarViewController: FSCalendarDelegate, FSCalendarDataSource {
    
    func calendar(_ calendar: FSCalendar, numberOfEventsFor date: Date) -> Int {
        let start = Calendar.current.startOfDay(for: date)
        let end = Calendar.current.date(byAdding: .day, value: 1, to: start) ?? Date()
        let predicate = NSPredicate(format: "endDate >= %@ && endDate < %@ ",
                                    start as NSDate, end as NSDate)
        
        return todoRepo.fetch(type: Todo.self).filter(predicate).count
    }
    
    func calendar(_ calendar: FSCalendar, didSelect date: Date, at monthPosition: FSCalendarMonthPosition) {
        let start = Calendar.current.startOfDay(for: date)
        let end = Calendar.current.date(byAdding: .day, value: 1, to: start) ?? Date()
        let predicate = NSPredicate(format: "endDate >= %@ && endDate < %@ ",
                                    start as NSDate, end as NSDate)
        
        list = todoRepo.fetch(type: Todo.self).filter(predicate)
        tableView.reloadData()
    }
}

// MARK: - TableView

extension CalendarViewController: UITableViewDelegate, UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        list.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: DetailCell.identifier, for: indexPath) as? DetailCell else { return UITableViewCell() }
        
        cell.configureCell(data: list[indexPath.row])
        return cell
    }
}
