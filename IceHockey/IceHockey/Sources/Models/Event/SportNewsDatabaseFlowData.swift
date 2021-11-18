//
//  SportNewsDatabaseFlowData.swift
//  IceHockey
//
//  Created by  Buxlan on 11/17/21.
//

import UIKit

protocol SportNewsDatabaseFlowData: SportEvent {
    var uid: String { get set }
    var authorID: String { get set }
    var title: String { get set }
    var text: String { get set }
    var boldText: String { get set }
    var type: SportEventType { get set }
    var date: Date { get set }
    var imageIDs: [String] { get set }
    var order: Int { get set }
    var author: SportUser? { get set }
}

struct DefaultSportNewsDatabaseFlowData: SportNewsDatabaseFlowData {
    var uid: String
    var authorID: String
    var title: String
    var text: String
    var boldText: String
    var type: SportEventType
    var date: Date
    var imageIDs: [String]
    var order: Int
    var author: SportUser?
    
    init() {
        self.uid = ""
        self.title = .empty
        self.text = .empty
        self.date = Date()
        self.type = .event
        self.boldText = ""
        self.imageIDs = []
        self.order = 0
        self.authorID = ""
    }
}

struct SportNewsDatabaseFlowDataImpl: SportNewsDatabaseFlowData {
    var uid: String
    var authorID: String
    var title: String
    var text: String
    var boldText: String
    var type: SportEventType
    var date: Date
    internal var imageIDs: [String] = []
    var order: Int
    var author: SportUser?
    
    init(uid: String,
         authorID: String,
         title: String,
         text: String,
         boldText: String,
         imageIDs: [String],
         date: Date,
         type: SportEventType = .event,
         order: Int) {
        self.uid = uid
        self.authorID = authorID
        self.title = title
        self.text = text
        self.date = date
        self.type = type
        self.boldText = boldText
        self.imageIDs = imageIDs
        self.order = order
    }
    
    internal init() {
        self.uid = ""
        self.title = .empty
        self.text = .empty
        self.date = Date()
        self.type = .event
        self.boldText = ""
        self.imageIDs = []
        self.order = 0
        self.authorID = ""
    }
    
    init?(key: String, dict: [String: Any]) {
        guard let text = dict["text"] as? String,
              let authorID = dict["author"] as? String,
              let boldText = dict["boldText"] as? String,
              let title = dict["title"] as? String,
              let rawType = dict["type"] as? Int,
              let type = SportEventType(rawValue: rawType),
              let dateInterval = dict["date"] as? Int,
              let order = dict["order"] as? Int else { return nil }
                
        self.uid = key
        self.authorID = authorID
        self.text = text
        self.title = title
        self.date = Date(timeIntervalSince1970: TimeInterval(dateInterval))
        self.imageIDs = dict["images"] as? [String] ?? []
        self.type = type
        self.boldText = boldText
        self.order = order
    }
    
}
