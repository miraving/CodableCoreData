//
//  Extension.swift
//  CodableCoreData
//
//  Created by Vitalii on 05.01.2022.
//

import UIKit
import CoreData

extension CodingUserInfoKey {
  static let managedObjectContext = CodingUserInfoKey(rawValue: "managedObjectContext")!
}

class ManagedObjectDecoder: JSONDecoder {
    let dateFormatter = DateFormatter()

    override init() {
        super.init()
        
        userInfo[CodingUserInfoKey.managedObjectContext] = (UIApplication.shared.delegate as? AppDelegate)?.persistentContainer.viewContext
//        dateDecodingStrategy = .iso8601
        dateFormatter.dateFormat = "yyyy-MM-dd'T'HH:mm:ss.SSS'Z'" // 2021-11-17T18:53:22.383Z
        dateDecodingStrategy = .formatted(dateFormatter)
    }
}
