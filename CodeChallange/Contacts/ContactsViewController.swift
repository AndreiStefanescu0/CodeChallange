//
//  ViewController.swift
//  CodeChallange
//
//  Created by Andrei Stefanescu on 24.06.2022.
//
import Alamofire
import UIKit
import CoreData

class ContactsViewController: UIViewController {
    
    @IBOutlet private weak var tableView: UITableView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        getContacts()
    }
    
    func getContacts() {
        AF.request("https://gorest.co.in/public/v2/users").response { [weak self] response in
            switch response.result {
            case .success( _):
                let jsonDecoder = JSONDecoder()
                jsonDecoder.keyDecodingStrategy = .convertFromSnakeCase
                if let data = response.data, let contacts = try? jsonDecoder.decode([UserInfo].self, from: data).filter({ $0.status == "active"}) {
                    self?.addContacts(contacts: contacts)
                }
            case .failure(let error):
                print(error)
            }
        }
    }
    
    func addContacts(contacts: [UserInfo]) {
        guard let appDelegate = UIApplication.shared.delegate as? AppDelegate else { return }
        let managedContext = appDelegate.persistentContainer.viewContext
        guard let entity = NSEntityDescription.entity(forEntityName: "User", in : managedContext) else { return }
        let record = NSManagedObject(entity: entity, insertInto: managedContext)
        contacts.forEach {
            record.setValue($0.name, forKey: "name")
            record.setValue($0.id, forKey: "id")
            record.setValue($0.email, forKey: "email")
            record.setValue($0.gender, forKey: "gender")
        }
        do {
            try managedContext.save()
            print("Record Added!")
        } catch
            let error as NSError {
            print("Could not save. \(error),\(error.userInfo)")
        }
    }
}

extension ContactsViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 5
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = 
    }
    
    
}

extension ContactsViewController: UITableViewDelegate {
    
}
