//
//  CalanderViewController.swift
//  SeSAC_TodoProject
//
//  Created by Deokhun KIM on 2/19/24.
//

import UIKit

import FSCalendar
import SnapKit

final class CalendarViewController: BaseViewController {
    
    // MARK: - Properties
    
    private let todoRepo = TodoRepository()
//    private var list: Results<Todo>!
    private lazy var calendar = FSCalendar().then {
        $0.delegate = self
        $0.dataSource = self
        $0.locale = Locale(identifier: "ko_KR")
        $0.appearance.titleDefaultColor = .label
        $0.appearance.eventDefaultColor = .label
        $0.appearance.headerTitleColor = .label
        $0.appearance.titleWeekendColor = .lightGray
        $0.appearance.weekdayTextColor = .label
        $0.appearance.selectionColor = .systemRed
        $0.appearance.todaySelectionColor = .systemBlue
        let gesture = UISwipeGestureRecognizer(target: self, action: #selector(calenderScrolled))
        gesture.direction = [.up, .down]
        $0.addGestureRecognizer(gesture)
    }
    private lazy var tableView = UITableView().then {
        $0.delegate = self
        $0.dataSource = self
        $0.register(DetailCell.self, forCellReuseIdentifier: DetailCell.identifier)
    }
    
    // MARK: - Lifecycles
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        todoRepo.list = todoRepo.fetch().filter(getTodayPredicate(date: Date()))
    }
    
    // MARK: - Selectors
    
    @objc func calenderScrolled(sender: UISwipeGestureRecognizer) {
        if calendar.scope == .week {
            calendar.scope = .month
        } else {
            calendar.scope = .week
        }
    }
    
    // MARK: - Helpers
    
    override func configureHierarchy() {
        view.addSubviews(calendar, tableView)
    }
    
    override func configureLayout() {
        calendar.snp.makeConstraints { make in
            make.top.horizontalEdges.equalTo(view.safeAreaLayoutGuide)
            make.height.equalTo(300)
        }
        
        tableView.snp.makeConstraints { make in
            make.top.equalTo(calendar.snp.bottom)
            make.horizontalEdges.bottom.equalToSuperview()
        }
    }
    
    override func configureView() {
        super.configureView()
        navigationItem.title = "캘린더"
    }
}

// MARK: - Calendar

extension CalendarViewController: FSCalendarDelegate, FSCalendarDataSource {
    
    func calendar(_ calendar: FSCalendar, numberOfEventsFor date: Date) -> Int {
        return todoRepo.fetch().filter(getTodayPredicate(date: date)).count
    }
    
    func calendar(_ calendar: FSCalendar, didSelect date: Date, at monthPosition: FSCalendarMonthPosition) {
        todoRepo.list = todoRepo.fetch().filter(getTodayPredicate(date: date))
        tableView.reloadData()
    }
}

// MARK: - TableView

extension CalendarViewController: UITableViewDelegate, UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        todoRepo.list.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: DetailCell.identifier, for: indexPath) as? DetailCell else { return UITableViewCell() }
        cell.configureCell(data: todoRepo.list[indexPath.row])
        return cell
    }
}
