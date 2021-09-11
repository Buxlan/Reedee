//
//  HockeyEvent.swift
//  IceHockey
//
//  Created by  Buxlan on 9/5/21.
//

import UIKit

struct SportEvent {
    var title: String
    var text: String
    var imageURL: URL?
    var actionTitle: String?
    var viewsCount: Int?
    
    init(title: String,
         text: String,
         imageURL: URL? = nil) {
        self.title = title
        self.text = text
        self.imageURL = imageURL
        self.viewsCount = Int.random(in: 1...10000)
    }
    
    internal init() {
        self.title = .empty
        self.text = .empty
        self.imageURL = nil
        self.viewsCount = 123
    }
    
}

extension SportEvent {
    
    static let empty = SportEvent()
    
    var image: UIImage {
        let emptyImage = Asset.event0.image
        guard let url = imageURL else {
            return emptyImage
        }
        guard let data = try? Data(contentsOf: url) else {
            return emptyImage
        }
        let image = UIImage(data: data)
        return image ?? emptyImage
    }
    
    static func getLastPinnedEvents(team: SportTeam,
                                    from: Int,
                                    count: Int = 10) -> [SportEvent] {
//        eventType = .pinned
        return [
            SportEvent(title: "Прикрепленная новость 0",
                       text: """
                        ВНИМАНИЮ НОВИЧКОВ, ЛЮБИТЕЛЕЙ и ПРОФЕССИОНАЛОВ ХОККЕЯ!
                       Хоккейный клуб «КРАСНЫЕ МЕДВЕДИ» открывает набор в группу для взрослых (18+) – МУЖЧИНЫ И ЖЕНЩИНЫ

                       Мы предлагаем:
                       • Профессиональный тренерский состав
                       • Удобное время тренировок
                       • Участие в товарищеских играх и хоккейных турнирах
                       • Дружный коллектив
"""),
            SportEvent(title: "Прикрепленная новость 1",
                       text: """
                        ВНИМАНИЮ НОВИЧКОВ, ЛЮБИТЕЛЕЙ и ПРОФЕССИОНАЛОВ ХОККЕЯ!
"""),
            SportEvent(title: "Прикрепленная новость 2",
                       text: """
                        ВНИМАНИЮ НОВИЧКОВ, ЛЮБИТЕЛЕЙ и ПРОФЕССИОНАЛОВ ХОККЕЯ!
"""),
            SportEvent(title: "Прикрепленная новость 3",
                       text: """
                        ВНИМАНИЮ НОВИЧКОВ, ЛЮБИТЕЛЕЙ и ПРОФЕССИОНАЛОВ ХОККЕЯ!
"""),
            SportEvent(title: "Прикрепленная новость 4",
                       text: """
                        ВНИМАНИЮ НОВИЧКОВ, ЛЮБИТЕЛЕЙ и ПРОФЕССИОНАЛОВ ХОККЕЯ!
"""),
            SportEvent(title: "Прикрепленная новость 5",
                       text: """
                        ВНИМАНИЮ НОВИЧКОВ, ЛЮБИТЕЛЕЙ и ПРОФЕССИОНАЛОВ ХОККЕЯ!
"""),
            SportEvent(title: "Прикрепленная новость 6",
                       text: """
                        ВНИМАНИЮ НОВИЧКОВ, ЛЮБИТЕЛЕЙ и ПРОФЕССИОНАЛОВ ХОККЕЯ!
""")
            
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
"""),
            SportEvent(title: "ОТКРЫВАЕТСЯ НАБОР В ГРУППУ ДЛЯ ВЗРОСЛЫХ",
                       text: """
                        ВНИМАНИЮ НОВИЧКОВ, ЛЮБИТЕЛЕЙ и ПРОФЕССИОНАЛОВ ХОККЕЯ!
""")
            
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
"""),
            SportEvent(title: "ОТКРЫВАЕТСЯ НАБОР В ГРУППУ ДЛЯ ВЗРОСЛЫХ",
                       text: """
                        ВНИМАНИЮ НОВИЧКОВ, ЛЮБИТЕЛЕЙ и ПРОФЕССИОНАЛОВ ХОККЕЯ!
""")
            
        ]
    }
    
}
