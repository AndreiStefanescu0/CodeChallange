//
//  User+CoreDataProperties.swift
//  CodeChallange
//
//  Created by Andrei Stefanescu on 24.06.2022.
//
//

import Foundation
import CoreData


extension User {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<User> {
        return NSFetchRequest<User>(entityName: "User")
    }

    @NSManaged public var name: String?
    @NSManaged public var id: Int16
    @NSManaged public var email: String?
    @NSManaged public var gender: String?
    @NSManaged public var phoneNumber: String?
    @NSManaged public var userProfileImage: Data?

}

extension User : Identifiable {

}
