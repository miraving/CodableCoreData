//
//  User+CoreDataProperties.swift
//  CodableCoreData
//
//  Created by Vitalii on 05.01.2022.
//
//

import Foundation
import CoreData


extension User {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<User> {
        return NSFetchRequest<User>(entityName: "User")
    }

    @NSManaged public var avatarUrl: URL?
    @NSManaged public var bio: String?
    @NSManaged public var blog: String?
    @NSManaged public var id: Int32
    @NSManaged public var login: String?
    @NSManaged public var name: String?
    @NSManaged public var type: String?
    @NSManaged public var url: String?

}

extension User : Identifiable {

}
