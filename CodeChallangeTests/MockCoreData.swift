//
//  MockCoreData.swift
//  CodeChallangeTests
//
//  Created by Andrei Stefanescu on 30.06.2022.
//

import Foundation
import CoreData

class MockCoreData: NSObject {
    lazy var persistentContainer: NSPersistentContainer = {
        let description = NSPersistentStoreDescription()
        description.url = URL(fileURLWithPath: "/dev/null")
        let container = NSPersistentContainer(name: "User")
        container.persistentStoreDescriptions = [description]
        container.loadPersistentStores { _, error in
            if let error = error as NSError? {
                fatalError("Unresolved error \(error), \(error.userInfo)")
            }
        }
        return container
    }()
}
