//
//  CodeChallangeTests.swift
//  CodeChallangeTests
//
//  Created by Andrei Stefanescu on 24.06.2022.
//

import XCTest
import CoreData
import UIKit
@testable import CodeChallange

class CodeChallangeTests: XCTestCase {
    
    private var localStorage: LocalStorage?
    private var context = TestCoreDataStack().persistentContainer.newBackgroundContext()
    
    override func setUpWithError() throws {
        guard let appDelegate = UIApplication.shared.delegate as? AppDelegate else { return }
        localStorage = LocalStorage(context: context, appDelegate: appDelegate)
        
    }
    
    override func tearDownWithError() throws {
        
    }
    
    func testSaveAndFetchUser() {
        saveRecord(completion: { fetchRecords in
            XCTAssertEqual(fetchRecords.first?.id, 123)
            XCTAssertEqual(fetchRecords.first?.name, "Andrei")
        })
    }
    
    func testUpdateUser() {
        let updatedUser = UserInfo(id: 123, name: "NewName", phoneNumber: "0787654321", status: "inactive", gender: "", email: "newEmail")
        saveRecord(completion: { [weak self] fetchRecords in
            self?.localStorage?.updateUser(user: updatedUser, completion: {
                let fetchRequest = self?.localStorage?.fetchRecords()
                XCTAssertEqual(fetchRequest?.first?.name, "NewName")
                XCTAssertEqual(fetchRequest?.first?.phoneNumber, "0787654321")
                XCTAssertEqual(fetchRequest?.first?.email, "newEmail")
            })
        })
    }
    
    private func saveRecord(completion: @escaping ([User]) -> Void) {
        let user = UserInfo(id: 123, name: "Andrei", phoneNumber: "0712345678", status: "active", gender: "M", email: "")
        guard let imageData = UIImage(systemName: "person")?.pngData() else { return }
        expectation(forNotification: .NSManagedObjectContextDidSave, object: context) { _ in
            return true
        }
        localStorage?.saveRecord(user: user, imageData: imageData, completion: { fetchRecords in
            self.waitForExpectations(timeout: 2.0) { error in
                XCTAssertNil(error, "Save did not occur")
            }
            completion(fetchRecords)
        })
    }
}

class TestCoreDataStack: NSObject {
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
