//
//  CalendarViewController.swift
//  IceHockey
//
//  Created by Sergey Bush bushmakin@outlook.com on 19.02.2022.
//

import SnapKit
import FSCalendar

class CalendarViewController: UIViewController {
    
    // MARK: - Properties
    
    var onReady: ([Date]) -> Void = { (_) in }
    var allowsMultipleSelection = false {
        didSet {
            calendarView.allowsMultipleSelection = allowsMultipleSelection
        }
    }
    
    private var firstDate: Date?
    private var lastDate: Date?
    private var datesRange: [Date]?
    
    
    private lazy var closeButton: UIButton = {
        let color = Asset.textColor.color
        let view = UIButton()
        view.backgroundColor = .white
        view.setTitle(L10n.Common.close, for: .normal)
        view.setTitleColor(color, for: .normal)
        view.titleLabel?.font = ResourceUtil.getRegularFont(17)
        view.contentEdgeInsets = .init(top: 9, left: 0, bottom: 9, right: 9)
        view.addTarget(self, action: #selector(closeHandle), for: .touchUpInside)
        return view
    }()
    
    private lazy var readyButton: UIButton = {
        let color = Asset.textColor.color
        let view = UIButton()
        view.backgroundColor = .white
        view.setTitle(L10n.Common.ready, for: .normal)
        view.setTitleColor(color, for: .normal)
        view.titleLabel?.font = ResourceUtil.getMediumFont(17)
        view.contentEdgeInsets = .init(top: 9, left: 9, bottom: 9, right: 0)
        view.addTarget(self, action: #selector(readyHandle), for: .touchUpInside)
        return view
    }()
    
    private lazy var weekdaysBackgroundView: UIView = {
        let view = UIView()
        view.backgroundColor = .red
        return view
    }()
    
    private lazy var calendarView: FSCalendar = {
        
        let selectionColor = Colors.Accent.orange
        
        let view = FSCalendar()
        view.firstWeekday = 2
        view.placeholderType = .none
        view.scrollDirection = .vertical
        view.pagingEnabled = false
        view.dataSource = self
        view.delegate = self
        view.allowsMultipleSelection = false
        view.appearance.headerDateFormat = "LLLL, yyyy"

        view.clipsToBounds = true

        view.appearance.headerTitleColor = Asset.textColor.color
        view.appearance.headerTitleFont = ResourceUtil.getBoldFont(22.0)
        view.appearance.headerTitleAlignment = .left
        view.appearance.caseOptions = [.headerUsesCapitalized, .weekdayUsesUpperCase]

        view.appearance.weekdayFont = ResourceUtil.getBoldFont(13.0)
        view.appearance.weekdayTextColor = Colors.Gray.medium
        
        view.appearance.titleTodayColor = Colors.Gray.dark
        view.appearance.titleDefaultColor = Colors.Gray.dark
        view.appearance.subtitleDefaultColor = Colors.Gray.dark
        view.appearance.titlePlaceholderColor = Colors.Gray.dark

        view.appearance.titleFont = ResourceUtil.getRegularFont(20.0)
        view.appearance.selectionColor = selectionColor
        view.appearance.headerMinimumDissolvedAlpha = 0.0
        view.appearance.todayColor = .clear
        view.appearance.eventDefaultColor = selectionColor
        
        return view
    }()
    
    // MARK: - Lifecircle
    
    init(selectedDates: [Date]) {
        super.init(nibName: nil, bundle: nil)
        
        selectedDates.forEach {
            calendarView.select($0)
        }
        firstDate = selectedDates.first
        lastDate = selectedDates.last
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()

        view.backgroundColor = .white
        
        view.addSubview(calendarView)
        view.addSubview(closeButton)
        view.addSubview(readyButton)
        
        configureConstraints()
        
    }
    
}

// MARK: - Helpers

extension CalendarViewController {
    
    private func configureConstraints() {
        
        closeButton.snp.makeConstraints { make in
            make.top.equalToSuperview().offset(20)
            make.leading.equalToSuperview().offset(32)
            make.height.equalTo(40)
        }
        
        readyButton.snp.makeConstraints { make in
            make.top.equalToSuperview().offset(20)
            make.trailing.equalToSuperview().offset(-32)
            make.height.equalTo(40)
        }
        
        calendarView.snp.makeConstraints { make in
            make.leading.equalToSuperview().offset(32)
            make.trailing.equalToSuperview().offset(-32)
            make.top.equalTo(closeButton.snp.bottom).offset(15)
            make.bottom.equalTo(view.safeAreaLayoutGuide.snp.bottom)
        }
        
//        weekdaysBackgroundView.snp.makeConstraints { make in
//            make.edges.equalToSuperview()
//        }
        
    }
    
    func datesRange(from: Date, to: Date) -> [Date] {
        
        if from > to { return [Date]() }

        var tempDate = from
        var array = [tempDate]

        while tempDate < to {
            tempDate = Calendar.current.date(byAdding: .day, value: 1, to: tempDate)!
            array.append(tempDate)
        }

        return array
    }
    
}

// MARK: - FSCalendar Data source

extension CalendarViewController: FSCalendarDataSource {
    
    func maximumDate(for calendar: FSCalendar) -> Date {
        return Date()
    }
    
}

// MARK: - FSCalendar Delegate

extension CalendarViewController: FSCalendarDelegate {
    
    func calendar(_ calendar: FSCalendar, didSelect date: Date, at monthPosition: FSCalendarMonthPosition) {
        
        guard allowsMultipleSelection else {
            firstDate = date
            lastDate = date
            datesRange = [date]
            return
        }
        
        // nothing selected:
        if firstDate == nil {
            firstDate = date
            datesRange = [date]
            return
        }

        // only first date is selected:
        if var firstDate = self.firstDate,
           lastDate == nil {
            
            var lastDate = date
            self.lastDate = lastDate
            
            if date <= firstDate {
                self.lastDate = firstDate
                lastDate = firstDate
                firstDate = date
                self.firstDate = date
            }

            let range = datesRange(from: firstDate, to: lastDate)

            range.forEach { date in
                calendar.select(date)
            }

            datesRange = range

            print("datesRange contains: (datesRange!)")

            return
        }

        // both are selected:
        if firstDate != nil && lastDate != nil {
            calendar.selectedDates.forEach { date in
                calendar.deselect(date)
            }

            lastDate = nil
            firstDate = nil

            datesRange = []

            print("datesRange contains: (datesRange!)")
        }
    }

    func calendar(_ calendar: FSCalendar, didDeselect date: Date, at monthPosition: FSCalendarMonthPosition) {

        if firstDate != nil && lastDate != nil {
            calendar.selectedDates.forEach { date in
                calendar.deselect(date)
            }

            lastDate = nil
            firstDate = nil

            datesRange = []
            print("datesRange contains: (datesRange!)")
        }
    }
    
    func calendar(_ calendar: FSCalendar, numberOfEventsFor date: Date) -> Int {
        if Calendar.current.isDateInToday(date) {
            return 1
        }
        return 0
    }
    
}

// MARK: - Actions

extension CalendarViewController {
    
    @objc private func closeHandle() {
        dismiss(animated: true)
    }
    
    @objc private func readyHandle() {
        let dates = calendarView.selectedDates.sorted { $0 < $1 }
        onReady(dates)
        dismiss(animated: true)
    }
    
}
