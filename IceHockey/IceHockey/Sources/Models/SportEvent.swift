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
    var boldText: String
    var actionTitle: String?
    var viewsCount: Int?
    var type: SportEventType
    var date: Date
    var imageIDs: [String] = []
    var order: Int
    
    init(uid: String,
         title: String,
         text: String,
         boldText: String,
         imagesNames: [String],
         actionTitle: String? = nil,
         date: Date,
         type: SportEventType = .match,
         order: Int) {
        self.uid = uid
        self.title = title
        self.text = text
        self.viewsCount = Int.random(in: 1...10000)
        self.actionTitle = actionTitle
        self.date = date
        self.type = type
        self.boldText = boldText
        self.imageIDs = imagesNames
        self.order = order
    }
    
    internal init() {
        self.uid = ""
        self.title = .empty
        self.text = .empty
        self.actionTitle = nil
        self.viewsCount = 123
        self.viewsCount = Int.random(in: 1...10000)
        self.date = Date()
        self.type = .event
        self.boldText = ""
        self.imageIDs = []
        self.order = 0
    }
    
    init?(snapshot: DataSnapshot) {
        let uid = snapshot.key
        guard let dict = snapshot.value as? [String: Any] else { return nil }
        guard let text = dict["text"] as? String else { return nil }
        guard let boldText = dict["boldText"] as? String else { return nil }
        guard let title = dict["title"] as? String else { return nil }
        guard let rawType = dict["type"] as? Int,
              let type = SportEventType(rawValue: rawType) else { return nil }
        guard let dateInterval = dict["date"] as? Int else { return nil }
        guard let order = dict["type"] as? Int else { return nil }
                
        self.uid = uid
        self.text = text
        self.title = title
        self.date = Date(timeIntervalSince1970: TimeInterval(dateInterval))
        self.imageIDs = dict["images"] as? [String] ?? []
        self.type = type
        self.boldText = boldText
        self.order = order
    }
    
}

extension SportEvent {
    
    var eventsDatabaseReference: DatabaseReference {
        FirebaseManager.shared.databaseManager.root.child("events")
    }
    
    var imagesDatabaseReference: DatabaseReference {
        FirebaseManager.shared.databaseManager.root.child("images")
    }
    
    var imagesStorageReference: StorageReference {
        let ref = FirebaseManager.shared.storageManager.root.child("events")
        return ref
    }
    
    var eventReference: DatabaseReference {
        var ref: DatabaseReference
        if isNew {
            ref = eventsDatabaseReference.childByAutoId()
        } else {
            ref = eventsDatabaseReference.child(uid)
        }
        return ref
    }
    
    func checkProperties() -> Bool {
        return true
    }
    
    func save() throws {
        
        if !checkProperties() {
            print("Error. Properties are wrong")
        }
        
        // for order purposes
        var dateComponent = DateComponents()
        dateComponent.calendar = Calendar.current
        dateComponent.year = 2024
        guard let templateDate = dateComponent.date else {
            fatalError()
        }
        let interval = self.date.timeIntervalSince1970
        let order = templateDate.timeIntervalSince(self.date)
        
        let dict: [String: Any] = [
            "uid": self.uid,
            "title": self.title,
            "text": self.text,
            "boldText": self.boldText,
            "actionTitle": self.actionTitle ?? "",
            "viewsCount": self.viewsCount ?? 0,
            "type": self.type.rawValue,
            "date": Int(interval),
            "images": self.imageIDs,
            "order": Int(order)
        ]
        
        eventReference.setValue(dict) { (error, ref) in
            if let error = error {
                print(error)
                return
            }
            guard let eventId = ref.key else {
                return
            }
            let imagesManager = ImagesManager.shared
            for imageId in imageIDs {
                let imageName = SportEvent.getImageName(forKey: imageId)
                let imageRef = imagesDatabaseReference.child(imageId)
                imageRef.setValue(imageName)
                let ref = imagesStorageReference.child(eventId).child(imageName)
                if let image = ImagesManager.shared.getCachedImage(forName: imageName),
                   let data = image.pngData() {
                    let task = ref.putData(data)
                    imagesManager.appendUploadTask(task)
                }
            }
            
//            var imagesDict: [String: String] = [:]
//            for imageId in imagesNames {
//                let imageName = getImageName(forKey: imageId)
//                imagesDict[imageId] = imageName
//                let ref = imagesStorageReference.child(eventId).child(imageName)
//                if let image = ImagesManager.shared.getCachedImage(forKey: imageId),
//                   let data = image.pngData() {
//                    let task = ref.putData(data)
//                    imagesManager.appendUploadTask(task)
//                }
//            }
//            imagesDatabaseReference.setValue(imagesDict) { (error, _) in
//                if let error = error {
//                    print(error)
//                    return
//                }
//            }
        }
    }
    
    var isNew: Bool {
        return self.uid.isEmpty
    }
    
    var mainImageName: String? {
        if imageIDs.count > 0 {
            return SportEvent.getImageName(forKey: imageIDs[0])
        }
        return nil
    }
    
}

extension SportEvent {
    
    mutating func appendImage(_ image: UIImage) {
        if let key = FirebaseManager.shared.databaseManager.getNewImageUID() {
            let imageName = SportEvent.getImageName(forKey: key)
            ImagesManager.shared.appendToCache(image, for: imageName)
            imageIDs.append(key)
        }
    }
    
    mutating func removeImage(withName imageName: String) {
        guard let index = imageIDs.firstIndex(of: imageName) else {
            return
        }
        ImagesManager.shared.removeFromCache(imageForKey: imageName)
        imageIDs.remove(at: index)
    }
    
    static func getImageName(forKey key: String) -> String {
        return key + ".png"
    }
    
}
    
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
