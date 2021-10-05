//
//  Team+CoreDataProperties.swift
//  
//
//  Created by  Buxlan on 10/1/21.
//
//

import Foundation
import CoreData


extension Team {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<Team> {
        return NSFetchRequest<Team>(entityName: "Team")
    }

    @NSManaged public var name: String?
    @NSManaged public var title: String?

}
