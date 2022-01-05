//
//  User+CoreDataClass.swift
//  CodableCoreData
//
//  Created by Vitalii on 05.01.2022.
//
//

import Foundation
import CoreData
import UIKit

@objc(User)
public class User: NSManagedObject, Codable {
    enum CodingKeys: String, CodingKey {
        case avatarUrl = "avatar_url"
        case name
        case type
        case bio
        case blog
        case id
        case login
        case url
    }
    
    public func encode(to encoder: Encoder) throws {
        var container = encoder.container(keyedBy: CodingKeys.self)
        try container.encode(avatarUrl, forKey: .avatarUrl)
        try container.encode(name, forKey: .name)
        try container.encode(type, forKey: .type)
        try container.encode(bio, forKey: .bio)
        try container.encode(blog, forKey: .blog)
        try container.encode(id, forKey: .id)
        try container.encode(login, forKey: .login)
        try container.encode(url, forKey: .url)
    }
    
    public required convenience init(from decoder: Decoder) throws {
        guard let managedObjectContext = decoder.userInfo[CodingUserInfoKey.managedObjectContext] as? NSManagedObjectContext else {
            fatalError()
        }
        
        guard let entity = NSEntityDescription.entity(forEntityName: "User", in: managedObjectContext) else {
            fatalError("Failed to decode User")
        }
        
        self.init(entity: entity, insertInto: managedObjectContext)
        
        let container = try decoder.container(keyedBy: CodingKeys.self)
        self.avatarUrl = try container.decodeIfPresent(URL.self, forKey: .avatarUrl)
        self.name = try container.decodeIfPresent(String.self, forKey: .name)
        self.type = try container.decodeIfPresent(String.self, forKey: .type)
        self.bio = try container.decodeIfPresent(String.self, forKey: .bio)
        self.blog = try container.decodeIfPresent(String.self, forKey: .blog)
        self.id = try container.decode(Int32.self, forKey: .id)
        self.login = try container.decodeIfPresent(String.self, forKey: .login)
        self.url = try container.decodeIfPresent(String.self, forKey: .url)
        
        try? managedObjectContext.save()
    }
}

