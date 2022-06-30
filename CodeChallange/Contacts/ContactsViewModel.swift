//
//  ContactsViewModel.swift
//  CodeChallange
//
//  Created by Andrei Stefanescu on 24.06.2022.
//

import UIKit

protocol ContactsViewModelDelegate {
    func retrieveContacts(users: [User])
}

protocol ContactsNavigationDelegate: AnyObject {
    func goToDetailScreen(user: User?, localStorage: LocalStorage)
}

class ContactsViewModel {
    private var localStorage: LocalStorage
    var contactsViewModelDelegate: ContactsViewModelDelegate?
    private var contactsNavigationDelegate: ContactsNavigationDelegate
    private var urlSession: URLSession
    
    init(localStorage: LocalStorage, contactsNavigationDelegate: ContactsNavigationDelegate, urlSession: URLSession) {
        self.localStorage = localStorage
        self.contactsNavigationDelegate = contactsNavigationDelegate
        self.urlSession = urlSession
    }
    
    private func getContacts() {
        urlSession.getContacts { [weak self] contacts in
            self?.addContacts(contacts: contacts)
        }
    }
    
    private func addContacts(contacts: [UserInfo]) {
        contacts.forEach {
            if $0.id % 2 == 0 {
                if let image = InitialsImageFactory.imageForEvenId(contact: $0) {
                    localStorage.saveRecord(user: $0, imageData: image, completion: { [weak self] users in
                        self?.contactsViewModelDelegate?.retrieveContacts(users: users)
                    })
                }
            } else {
                InitialsImageFactory.imageForOddId(contact: $0, completion: { [weak self] (image, user) in
                    if let image = image {
                        self?.localStorage.saveRecord(user: user, imageData: image, completion: { [weak self] users in
                            self?.contactsViewModelDelegate?.retrieveContacts(users: users)
                        })
                    }
                })
            }
        }
    }
    
    func goToContactDetail(_ user: User?) {
        contactsNavigationDelegate.goToDetailScreen(user: user, localStorage: localStorage)
    }
    
    func fetchData(completion: @escaping ([User]) -> Void) {
        let recordsFound = localStorage.fetchRecords()
        recordsFound.isEmpty ? getContacts() : completion(recordsFound)
    }
}
