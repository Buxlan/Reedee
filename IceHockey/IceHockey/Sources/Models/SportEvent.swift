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
}

struct SportEvent {
    var title: String
    var text: String
    var imageURL: URL?
    var imageName: String?
    var actionTitle: String?
    var viewsCount: Int?
    var type: SportEventType = .other
    
    init(title: String,
         text: String,
         imageName: String?,
         imageURL: URL? = nil) {
        self.title = title
        self.text = text
        self.imageURL = imageURL
        self.viewsCount = Int.random(in: 1...10000)
        self.imageName = imageName
    }
    
    internal init() {
        self.title = .empty
        self.text = .empty
        self.imageURL = nil
        self.viewsCount = 123
        self.imageName = nil
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
""", imageName: "event0"),
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
""", imageName: "event0"),
            SportEvent(title: "Прикрепленная новость 5",
                       text: """
                        ВНИМАНИЮ НОВИЧКОВ, ЛЮБИТЕЛЕЙ и ПРОФЕССИОНАЛОВ ХОККЕЯ!
""", imageName: "event1"),
            SportEvent(title: "Прикрепленная новость 6",
                       text: """
                        ВНИМАНИЮ НОВИЧКОВ, ЛЮБИТЕЛЕЙ и ПРОФЕССИОНАЛОВ ХОККЕЯ!
""", imageName: "event3")
            
        ]
    }
    
    static func getLastEvents(team: SportTeam,
                              from: Int,
                              count: Int = 10) -> [SportEvent] {
        //        eventType = .events
        return [
            SportEvent(title: "ОТКРЫВАЕТСЯ НАБОР В ГРУППУ ДЛЯ ВЗРОСЛЫХ",
                       text: """
                        ВНИМАНИЮ НОВИЧКОВ, ЛЮБИТЕЛЕЙ и ПРОФЕССИОНАЛОВ ХОККЕЯ!
                       Хоккейный клуб «КРАСНЫЕ МЕДВЕДИ» открывает набор в группу для взрослых (18+) – МУЖЧИНЫ И ЖЕНЩИНЫ

                       Мы предлагаем:
                       • Профессиональный тренерский состав
                       • Удобное время тренировок
                       • Участие в товарищеских играх и хоккейных турнирах
                       • Дружный коллектив
""", imageName: "event0"),
            SportEvent(title: "ОТКРЫВАЕТСЯ НАБОР В ГРУППУ ДЛЯ ВЗРОСЛЫХ",
                       text: """
                        ВНИМАНИЮ НОВИЧКОВ, ЛЮБИТЕЛЕЙ и ПРОФЕССИОНАЛОВ ХОККЕЯ!
""", imageName: "event0")
            
        ]
    }
    
    static func getComingEvents(team: SportTeam,
                                from: Int,
                                count: Int = 10) -> [SportEvent] {
        //        eventType = .coming
        return [
            SportEvent(title: "ОТКРЫВАЕТСЯ НАБОР В ГРУППУ ДЛЯ ВЗРОСЛЫХ",
                       text: """
                        ВНИМАНИЮ НОВИЧКОВ, ЛЮБИТЕЛЕЙ и ПРОФЕССИОНАЛОВ ХОККЕЯ!
                       Хоккейный клуб «КРАСНЫЕ МЕДВЕДИ» открывает набор в группу для взрослых (18+) – МУЖЧИНЫ И ЖЕНЩИНЫ

                       Мы предлагаем:
                       • Профессиональный тренерский состав
                       • Удобное время тренировок
                       • Участие в товарищеских играх и хоккейных турнирах
                       • Дружный коллектив
""", imageName: "event0"),
            SportEvent(title: "ОТКРЫВАЕТСЯ НАБОР В ГРУППУ ДЛЯ ВЗРОСЛЫХ",
                       text: """
                        ВНИМАНИЮ НОВИЧКОВ, ЛЮБИТЕЛЕЙ и ПРОФЕССИОНАЛОВ ХОККЕЯ!
""", imageName: "event0")
            
        ]
    }
    
}
