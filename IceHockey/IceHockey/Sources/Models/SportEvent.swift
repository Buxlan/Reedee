//
//  HockeyEvent.swift
//  IceHockey
//
//  Created by  Buxlan on 9/5/21.
//

import UIKit

enum SportEventType: Int {
    case match
    case ad
    case event
    case other
    case photo
    case comingSoon
}

extension SportEventType {
    var description: String {
        switch self {
        case .match:
            return L10n.Events.typeMatch
        case .ad:
            return L10n.Events.typeAd
        case .event:
            return L10n.Events.typeEvent
        case .other:
            return L10n.Events.typeOther
        case .photo:
            return L10n.Events.typePhoto
        case .comingSoon:
            return L10n.Events.typeComingSoon
        }
    }
    var backgroundColor: UIColor {
        switch self {
        case .match:
            return Asset.accent0.color
        case .ad:
            return Asset.accent1.color
        case .event:
            return Asset.accent2.color
        case .other:
            return Asset.accent3.color
        case .photo:
            return Asset.accent0.color
        case .comingSoon:
            return Asset.accent1.color
        }
    }
    
    var textColor: UIColor {
        switch self {
        case .match:
            return Asset.other2.color
        case .ad:
            return Asset.other2.color
        case .event:
            return Asset.other2.color
        case .other:
            return Asset.other2.color
        case .photo:
            return Asset.other2.color
        case .comingSoon:
            return Asset.other2.color
        }
    }
}

struct SportEvent {
    var title: String
    var text: String
    var imageURL: URL?
    var imageName: String?
    var actionTitle: String?
    var viewsCount: Int?
    var type: SportEventType
    var date: Date?
    
    init(title: String,
         text: String,
         imageName: String?,
         imageURL: URL? = nil,
         date: Date? = nil,
         type: SportEventType = .match) {
        self.title = title
        self.text = text
        self.imageURL = imageURL
        self.viewsCount = Int.random(in: 1...10000)
        self.imageName = imageName
        self.date = date
        self.type = type
    }
    
    internal init() {
        self.title = .empty
        self.text = .empty
        self.imageURL = nil
        self.viewsCount = 123
        self.imageName = nil
        self.date = nil
        self.type = .match
    }
    
}

extension SportEvent {
    
    static let empty = SportEvent()
    
    var image: UIImage {
        let emptyImage = Asset.event0.image
        var image: UIImage?
        if let imageName = imageName {
            image = UIImage(named: imageName)
        } else if let url = imageURL {
            if let data = try? Data(contentsOf: url) {
                image = UIImage(data: data)
            }
        }
        return image ?? emptyImage
    }
    
    static func pinnedEvents(team: SportTeam,
                             from: Int,
                             count: Int = 10) -> [SportEvent] {
        //        eventType = .pinned
        return [
            SportEvent(title: "Открыт набор во взрослую любителькую команду",
                       text: """
                        ВНИМАНИЮ НОВИЧКОВ, ЛЮБИТЕЛЕЙ и ПРОФЕССИОНАЛОВ ХОККЕЯ!
                       Хоккейный клуб «КРАСНЫЕ МЕДВЕДИ» открывает набор в группу для взрослых (18+) – МУЖЧИНЫ И ЖЕНЩИНЫ

                       Мы предлагаем:
                       • Профессиональный тренерский состав
                       • Удобное время тренировок
                       • Участие в товарищеских играх и хоккейных турнирах
                       • Дружный коллектив
""",
                       imageName: "event0"),
            SportEvent(title: "Открыт набор детей от 3-х лет",
                       text: """
                        ВНИМАНИЮ НОВИЧКОВ, ЛЮБИТЕЛЕЙ и ПРОФЕССИОНАЛОВ ХОККЕЯ!
""", imageName: "event1"),
            SportEvent(title: "Акция: скидка 25% на 2-го ребенка",
                       text: """
                        ВНИМАНИЮ НОВИЧКОВ, ЛЮБИТЕЛЕЙ и ПРОФЕССИОНАЛОВ ХОККЕЯ!
""", imageName: "event2"),
            SportEvent(title: "Прикрепленная новость 3",
                       text: """
                        ВНИМАНИЮ НОВИЧКОВ, ЛЮБИТЕЛЕЙ и ПРОФЕССИОНАЛОВ ХОККЕЯ!
""", imageName: "event3"),
            SportEvent(title: "Прикрепленная новость 4",
                       text: """
                        ВНИМАНИЮ НОВИЧКОВ, ЛЮБИТЕЛЕЙ и ПРОФЕССИОНАЛОВ ХОККЕЯ!
""", imageName: "event4"),
            SportEvent(title: "Прикрепленная новость 5",
                       text: """
                        ВНИМАНИЮ НОВИЧКОВ, ЛЮБИТЕЛЕЙ и ПРОФЕССИОНАЛОВ ХОККЕЯ!
""", imageName: "event5"),
            SportEvent(title: "Прикрепленная новость 6",
                       text: """
                        ВНИМАНИЮ НОВИЧКОВ, ЛЮБИТЕЛЕЙ и ПРОФЕССИОНАЛОВ ХОККЕЯ!
""", imageName: "event6")
            
        ]
    }
    
    static func photoEvents(team: SportTeam,
                            from: Int,
                            count: Int = 10) -> [SportEvent] {
        //        eventType = .pinned
        return [
            SportEvent(title: "Открыт набор во взрослую любителькую команду",
                       text: """
                        ВНИМАНИЮ НОВИЧКОВ, ЛЮБИТЕЛЕЙ и ПРОФЕССИОНАЛОВ ХОККЕЯ!
                       Хоккейный клуб «КРАСНЫЕ МЕДВЕДИ» открывает набор в группу для взрослых (18+) – МУЖЧИНЫ И ЖЕНЩИНЫ

                       Мы предлагаем:
                       • Профессиональный тренерский состав
                       • Удобное время тренировок
                       • Участие в товарищеских играх и хоккейных турнирах
                       • Дружный коллектив
""",
                       imageName: "event0"),
            SportEvent(title: "Открыт набор детей от 3-х лет",
                       text: """
                        ВНИМАНИЮ НОВИЧКОВ, ЛЮБИТЕЛЕЙ и ПРОФЕССИОНАЛОВ ХОККЕЯ!
""", imageName: "event1"),
            SportEvent(title: "Акция: скидка 25% на 2-го ребенка",
                       text: """
                        ВНИМАНИЮ НОВИЧКОВ, ЛЮБИТЕЛЕЙ и ПРОФЕССИОНАЛОВ ХОККЕЯ!
""", imageName: "event2"),
            SportEvent(title: "Прикрепленная новость 3",
                       text: """
                        ВНИМАНИЮ НОВИЧКОВ, ЛЮБИТЕЛЕЙ и ПРОФЕССИОНАЛОВ ХОККЕЯ!
""", imageName: "event3"),
            SportEvent(title: "Прикрепленная новость 4",
                       text: """
                        ВНИМАНИЮ НОВИЧКОВ, ЛЮБИТЕЛЕЙ и ПРОФЕССИОНАЛОВ ХОККЕЯ!
""", imageName: "event4"),
            SportEvent(title: "Прикрепленная новость 5",
                       text: """
                        ВНИМАНИЮ НОВИЧКОВ, ЛЮБИТЕЛЕЙ и ПРОФЕССИОНАЛОВ ХОККЕЯ!
""", imageName: "event5"),
            SportEvent(title: "Прикрепленная новость 6",
                       text: """
                        ВНИМАНИЮ НОВИЧКОВ, ЛЮБИТЕЛЕЙ и ПРОФЕССИОНАЛОВ ХОККЕЯ!
""", imageName: "event6")
            
        ]
    }
    
    static func getLastEvents(team: SportTeam,
                              from: Int,
                              count: Int = 10) -> [SportEvent] {
        //        eventType = .events
        return [
            SportEvent(title: "Поздравляем команду 2015 г.р. с победой!",
                       text: """
                        ВНИМАНИЮ НОВИЧКОВ, ЛЮБИТЕЛЕЙ и ПРОФЕССИОНАЛОВ ХОККЕЯ!
                       Хоккейный клуб «КРАСНЫЕ МЕДВЕДИ» открывает набор в группу для взрослых (18+) – МУЖЧИНЫ И ЖЕНЩИНЫ

                       Мы предлагаем:
                       • Профессиональный тренерский состав
                       • Удобное время тренировок
                       • Участие в товарищеских играх и хоккейных турнирах
                       • Дружный коллектив
""", imageName: "event4", type: .match),
            SportEvent(title: "Акция на клубную атрибутику в нашем магазине",
                       text: """
                        ВНИМАНИЮ НОВИЧКОВ, ЛЮБИТЕЛЕЙ и ПРОФЕССИОНАЛОВ ХОККЕЯ!
""", imageName: "event5", type: .other),
            SportEvent(title: "C Днем Тренера",
                       text: """
                        ВНИМАНИЮ НОВИЧКОВ, ЛЮБИТЕЛЕЙ и ПРОФЕССИОНАЛОВ ХОККЕЯ!
""", imageName: "event6", type: .other)
            
        ]
    }
    
    static func getComingEvents(team: SportTeam,
                                from: Int,
                                count: Int = 10) -> [SportEvent] {
        //        eventType = .coming
        return [
            SportEvent(title: "Массовое катание",
                       text: """
                        ВНИМАНИЮ НОВИЧКОВ, ЛЮБИТЕЛЕЙ и ПРОФЕССИОНАЛОВ ХОККЕЯ!
                       Хоккейный клуб «КРАСНЫЕ МЕДВЕДИ» открывает набор в группу для взрослых (18+) – МУЖЧИНЫ И ЖЕНЩИНЫ

                       Мы предлагаем:
                       • Профессиональный тренерский состав
                       • Удобное время тренировок
                       • Участие в товарищеских играх и хоккейных турнирах
                       • Дружный коллектив
""", imageName: "event4", type: .other),
            SportEvent(title: "Впервые в России - лазертаг на льду!",
                       text: """
                        ВНИМАНИЮ НОВИЧКОВ, ЛЮБИТЕЛЕЙ и ПРОФЕССИОНАЛОВ ХОККЕЯ!
""", imageName: "event6"),
            SportEvent(title: "Сезонные сборы команды 2012 пройдут с 12 по 24 августа 2021",
                       text: """
                        ВНИМАНИЮ НОВИЧКОВ, ЛЮБИТЕЛЕЙ и ПРОФЕССИОНАЛОВ ХОККЕЯ!
""", imageName: "event7")
            
        ]
    }
    
}
