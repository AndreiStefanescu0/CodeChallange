//
//  LocalStorage.swift
//  CodeChallange
//
//  Created by Andrei Stefanescu on 26.06.2022.
//

import CoreData
import UIKit

protocol LocalStorageProtocol {
    func saveRecord(user: UserInfo, imageData: Data, managedContext: NSManagedObjectContext, completion: @escaping ([User]) -> (Void))
    func fetchRecords(context: NSManagedObjectContext) -> [User]
    func updateUser(user: UserInfo)
}

enum Error: String, LocalizedError {
    case error
    
    var errorDescription: String? {
        rawValue
    }
}

class LocalStorage {
    private var context: NSManagedObjectContext?
    private var container: NSPersistentContainer {
        let container = NSPersistentContainer(name: "User")
        container.loadPersistentStores(completionHandler: { (storeDescription, error) in
            if let error = error as NSError? {
                fatalError("Unresolved error \(error), \(error.userInfo)")
            }
        })
        return container
    }
    
    init(context: NSManagedObjectContext? = nil) {
        self.context = context
        if context == nil {
            self.context = container.viewContext
        }
    }
    
    func saveRecord(user: UserInfo, imageData: Data, completion: @escaping ([User]) -> (Void)) {
        guard let context = context,
            let entity = NSEntityDescription.entity(forEntityName: "User", in : context) else {
            return
        }
        let record = NSManagedObject(entity: entity, insertInto: context)
        record.setValue(user.name, forKey: "name")
        record.setValue(user.id, forKey: "id")
        record.setValue(user.email, forKey: "email")
        record.setValue(user.gender, forKey: "gender")
        record.setValue(imageData, forKey: "userProfileImage")
        do {
            try context.save()
            completion(fetchRecords())
        } catch let error as NSError {
            print("Fetch error: \(error) description: \(error.userInfo)")
        }
    }
    
    func updateUser(user: UserInfo, completion: @escaping () -> (Void)) {
        guard let context = context else {
            return
        }
        let fetchRequest: NSFetchRequest<User> = User.fetchRequest()
        fetchRequest.predicate = NSPredicate(format: "id = %i", user.id as CVarArg)
        do {
            let record = try context.fetch(fetchRequest).first
            record?.setValue(user.name, forKey: "name")
            record?.setValue(user.phoneNumber, forKey: "phoneNumber")
            record?.setValue(user.email, forKey: "email")
        } catch {
            print("Fetch Failed: \(error)")
        }
        do {
            try context.save()
            completion()
        }
        catch {
            print("Saving Core Data Failed: \(error)")
        }
    }
    
    func fetchRecords() -> [User] {
        guard let context = context else {
            return []
        }

        let fetchRequest: NSFetchRequest<User> = User.fetchRequest()
        do {
            return try context.fetch(fetchRequest)
        } catch let error as NSError {
            print("Fetch error: \(error) description: \(error.userInfo)")
        }
        return []
    }
}
