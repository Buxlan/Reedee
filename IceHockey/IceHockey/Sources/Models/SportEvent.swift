//
//  HockeyEvent.swift
//  IceHockey
//
//  Created by  Buxlan on 9/5/21.
//

import UIKit
import Firebase

struct SportEvent: Hashable {
    var uid: String
    var title: String
    var text: String
    var imagePath: String
    var actionTitle: String?
    var viewsCount: Int?
    var type: SportEventType
    var date: Date?
    
    init(uid: String,
         title: String,
         text: String,
         imagePath: String,
         imageURL: String? = nil,
         actionTitle: String? = nil,
         date: Date? = nil,
         type: SportEventType = .match) {
        self.uid = uid
        self.title = title
        self.text = text
        self.imagePath = imagePath
        self.viewsCount = Int.random(in: 1...10000)
        self.actionTitle = actionTitle
        self.date = date
        self.type = type
    }
    
    internal init() {
        self.uid = ""
        self.title = .empty
        self.text = .empty
        self.imagePath = ""
        self.actionTitle = nil
        self.viewsCount = 123
        self.viewsCount = Int.random(in: 1...10000)
        self.date = nil
        self.type = .match
    }
    
    init?(snapshot: DataSnapshot) {
        guard let dict = snapshot.value as? [String: Any] else { return nil }
        guard let uid = dict["uid"] as? String else { return nil }
        guard let text = dict["text"] as? String else { return nil }
        guard let title = dict["title"] as? String else { return nil }
        guard let rawType = dict["type"] as? Int,
              let type = SportEventType(rawValue: rawType) else { return nil }
        guard let dateInterval = dict["date"] as? Int else { return nil }
        
        self.uid = uid
        self.text = text
        self.title = title
        self.date = Date(timeIntervalSince1970: TimeInterval(dateInterval))
        self.imagePath = dict["imagePath"] as? String ?? ""
        self.type = type
    }
    
}

extension SportEvent {
    
    static let empty = SportEvent()
    
//    var image: UIImage {
//        let emptyImage = Asset.event0.image
//        var image: UIImage?
//        if let imagePath = imagePath {
//            image = UIImage(named: imagePath)
//        } else if let urlString = imageURL,
//                  let url = URL(string: urlString) {            
//            if let data = try? Data(contentsOf: url) {
//                image = UIImage(data: data)
//            }
//        }
//        return image ?? emptyImage
//    }
    
}
    
//    static func pinnedEvents(team: SportTeam,
//                             from: Int,
//                             count: Int = 10) -> [SportEvent] {
//        //        eventType = .pinned
//        return [
//            SportEvent(title: "Открыт набор во взрослую любителькую команду",
//                       text: """
//                        ВНИМАНИЮ НОВИЧКОВ, ЛЮБИТЕЛЕЙ и ПРОФЕССИОНАЛОВ ХОККЕЯ!
//                       Хоккейный клуб «КРАСНЫЕ МЕДВЕДИ» открывает набор в группу для взрослых (18+) – МУЖЧИНЫ И ЖЕНЩИНЫ
//
//                       Мы предлагаем:
//                       • Профессиональный тренерский состав
//                       • Удобное время тренировок
//                       • Участие в товарищеских играх и хоккейных турнирах
//                       • Дружный коллектив
//""",
//                       imageName: "event0"),
//            SportEvent(title: "Открыт набор детей от 3-х лет",
//                       text: """
//                        ВНИМАНИЮ НОВИЧКОВ, ЛЮБИТЕЛЕЙ и ПРОФЕССИОНАЛОВ ХОККЕЯ!
//""", imageName: "event1"),
//            SportEvent(title: "Акция: скидка 25% на 2-го ребенка",
//                       text: """
//                        ВНИМАНИЮ НОВИЧКОВ, ЛЮБИТЕЛЕЙ и ПРОФЕССИОНАЛОВ ХОККЕЯ!
//""", imageName: "event2"),
//            SportEvent(title: "Прикрепленная новость 3",
//                       text: """
//                        ВНИМАНИЮ НОВИЧКОВ, ЛЮБИТЕЛЕЙ и ПРОФЕССИОНАЛОВ ХОККЕЯ!
//""", imageName: "event3"),
//            SportEvent(title: "Прикрепленная новость 4",
//                       text: """
//                        ВНИМАНИЮ НОВИЧКОВ, ЛЮБИТЕЛЕЙ и ПРОФЕССИОНАЛОВ ХОККЕЯ!
//""", imageName: "event4"),
//            SportEvent(title: "Прикрепленная новость 5",
//                       text: """
//                        ВНИМАНИЮ НОВИЧКОВ, ЛЮБИТЕЛЕЙ и ПРОФЕССИОНАЛОВ ХОККЕЯ!
//""", imageName: "event5"),
//            SportEvent(title: "Прикрепленная новость 6",
//                       text: """
//                        ВНИМАНИЮ НОВИЧКОВ, ЛЮБИТЕЛЕЙ и ПРОФЕССИОНАЛОВ ХОККЕЯ!
//""", imageName: "event6")
//
//        ]
//    }
    
//    static func photoEvents(team: SportTeam,
//                            from: Int,
//                            count: Int = 10) -> [SportEvent] {
//        //        eventType = .pinned
//        return [
//            SportEvent(title: "Открыт набор во взрослую любителькую команду",
//                       text: """
//                        ВНИМАНИЮ НОВИЧКОВ, ЛЮБИТЕЛЕЙ и ПРОФЕССИОНАЛОВ ХОККЕЯ!
//                       Хоккейный клуб «КРАСНЫЕ МЕДВЕДИ» открывает набор в группу для взрослых (18+) – МУЖЧИНЫ И ЖЕНЩИНЫ
//
//                       Мы предлагаем:
//                       • Профессиональный тренерский состав
//                       • Удобное время тренировок
//                       • Участие в товарищеских играх и хоккейных турнирах
//                       • Дружный коллектив
//""",
//                       imageName: "event0"),
//            SportEvent(title: "Открыт набор детей от 3-х лет",
//                       text: """
//                        ВНИМАНИЮ НОВИЧКОВ, ЛЮБИТЕЛЕЙ и ПРОФЕССИОНАЛОВ ХОККЕЯ!
//""", imageName: "event1"),
//            SportEvent(title: "Акция: скидка 25% на 2-го ребенка",
//                       text: """
//                        ВНИМАНИЮ НОВИЧКОВ, ЛЮБИТЕЛЕЙ и ПРОФЕССИОНАЛОВ ХОККЕЯ!
//""", imageName: "event2"),
//            SportEvent(title: "Прикрепленная новость 3",
//                       text: """
//                        ВНИМАНИЮ НОВИЧКОВ, ЛЮБИТЕЛЕЙ и ПРОФЕССИОНАЛОВ ХОККЕЯ!
//""", imageName: "event3"),
//            SportEvent(title: "Прикрепленная новость 4",
//                       text: """
//                        ВНИМАНИЮ НОВИЧКОВ, ЛЮБИТЕЛЕЙ и ПРОФЕССИОНАЛОВ ХОККЕЯ!
//""", imageName: "event4"),
//            SportEvent(title: "Прикрепленная новость 5",
//                       text: """
//                        ВНИМАНИЮ НОВИЧКОВ, ЛЮБИТЕЛЕЙ и ПРОФЕССИОНАЛОВ ХОККЕЯ!
//""", imageName: "event5"),
//            SportEvent(title: "Прикрепленная новость 6",
//                       text: """
//                        ВНИМАНИЮ НОВИЧКОВ, ЛЮБИТЕЛЕЙ и ПРОФЕССИОНАЛОВ ХОККЕЯ!
//""", imageName: "event6")
//
//        ]
//    }
//
//    static func getLastEvents(team: SportTeam,
//                              from: Int,
//                              count: Int = 10) -> [SportEvent] {
//        //        eventType = .events
//        return [
//            SportEvent(title: "Поздравляем команду 2015 г.р. с победой!",
//                       text: """
//                        ВНИМАНИЮ НОВИЧКОВ, ЛЮБИТЕЛЕЙ и ПРОФЕССИОНАЛОВ ХОККЕЯ!
//                       Хоккейный клуб «КРАСНЫЕ МЕДВЕДИ» открывает набор в группу для взрослых (18+) – МУЖЧИНЫ И ЖЕНЩИНЫ
//
//                       Мы предлагаем:
//                       • Профессиональный тренерский состав
//                       • Удобное время тренировок
//                       • Участие в товарищеских играх и хоккейных турнирах
//                       • Дружный коллектив
//""", imageName: "event4", type: .match),
//            SportEvent(title: "Акция на клубную атрибутику в нашем магазине",
//                       text: """
//                        ВНИМАНИЮ НОВИЧКОВ, ЛЮБИТЕЛЕЙ и ПРОФЕССИОНАЛОВ ХОККЕЯ!
//""", imageName: "event5", type: .other),
//            SportEvent(title: "C Днем Тренера",
//                       text: """
//                        ВНИМАНИЮ НОВИЧКОВ, ЛЮБИТЕЛЕЙ и ПРОФЕССИОНАЛОВ ХОККЕЯ!
//""", imageName: "event6", type: .other)
//
//        ]
//    }
//
//    static func getComingEvents(team: SportTeam,
//                                from: Int,
//                                count: Int = 10) -> [SportEvent] {
//        //        eventType = .coming
//        return [
//            SportEvent(title: "Массовое катание",
//                       text: """
//                        ВНИМАНИЮ НОВИЧКОВ, ЛЮБИТЕЛЕЙ и ПРОФЕССИОНАЛОВ ХОККЕЯ!
//                       Хоккейный клуб «КРАСНЫЕ МЕДВЕДИ» открывает набор в группу для взрослых (18+) – МУЖЧИНЫ И ЖЕНЩИНЫ
//
//                       Мы предлагаем:
//                       • Профессиональный тренерский состав
//                       • Удобное время тренировок
//                       • Участие в товарищеских играх и хоккейных турнирах
//                       • Дружный коллектив
//""", imageName: "event4", type: .other),
//            SportEvent(title: "Впервые в России - лазертаг на льду!",
//                       text: """
//                        ВНИМАНИЮ НОВИЧКОВ, ЛЮБИТЕЛЕЙ и ПРОФЕССИОНАЛОВ ХОККЕЯ!
//""", imageName: "event6"),
//            SportEvent(title: "Сезонные сборы команды 2012 пройдут с 12 по 24 августа 2021",
//                       text: """
//                        ВНИМАНИЮ НОВИЧКОВ, ЛЮБИТЕЛЕЙ и ПРОФЕССИОНАЛОВ ХОККЕЯ!
//""", imageName: "event7")
//
//        ]
//    }  
