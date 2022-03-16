//
//  DatePickerButton.swift
//  IceHockey
//
//  Created by Sergey Bush bushmakin@outlook.com on 19.02.2022.
//

import UIKit

class DatePickerButton: UIButton {
    
    var onSelect = {}
    
    private var defaultTitle = L10n.Common.defaultDatePickerTitle
    
    // MARK: - Lifecirle
    
    override init(frame: CGRect = .zero) {
        super.init(frame: frame)
        let color: UIColor = Asset.textColor.color
        let image = Asset.calendar.image
            .resizeImage(to: 16, aspectRatio: .current)
            .withRenderingMode(.alwaysTemplate)
        backgroundColor = .white
        layer.cornerRadius = 4
        titleLabel?.font = Fonts.Regular.subhead
        setImage(image, for: .normal)
        setTitle(defaultTitle, for: .normal)
        setTitleColor(color, for: .normal)
        backgroundColor = .white
        tintColor = color
        imageEdgeInsets = .init(top: 0, left: -4, bottom: 0, right: 4)
        titleEdgeInsets = .init(top: 0, left: 4, bottom: 0, right: -4)
        addTarget(self, action: #selector(selectDateHandle), for: .touchUpInside)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: - Helpers
    
    func configure(startDate: Date?, endDate: Date?) {
        let title = getTitle(startDate: startDate, endDate: endDate)
        setTitle(title, for: .normal)
    }
    
    private func getTitle(startDate: Date?, endDate: Date?) -> String {
        
        if startDate == nil,
           endDate == nil {
            return defaultTitle
        }
        
        var title = ""
        
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "dd.MM.yy"
        
        if let startDate = startDate,
           let endDate = endDate,
           startDate != endDate {
            var yearComponent = ""
            if startDate.isInSameYear(as: endDate) {
                dateFormatter.dateFormat = "yyyy"
                yearComponent = dateFormatter.string(from: startDate)
                dateFormatter.dateFormat = "dd.MM"
            }
            let startDateTitle = dateFormatter.string(from: startDate)
            let endDateTitle = dateFormatter.string(from: endDate)
            title = "\(startDateTitle)-\(endDateTitle).\(yearComponent)"
        } else if let startDate = startDate {
            title = dateFormatter.string(from: startDate)
        } else if let endDate = endDate {
            title = dateFormatter.string(from: endDate)
        }
        
        if frame.width < 200,
           title.count >= 12 {
            let lastIndex = title.index(title.startIndex, offsetBy: 12)
            let range = title.startIndex..<lastIndex
            title = String(title[range]) + "..."
        }
        
        return title
        
    }
    
    @objc private func selectDateHandle() {
        onSelect()
    }
    
}
