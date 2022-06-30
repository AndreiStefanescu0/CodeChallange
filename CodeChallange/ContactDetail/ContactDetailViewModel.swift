//
//  ContactDetailViewModel.swift
//  CodeChallange
//
//  Created by Andrei Stefanescu on 28.06.2022.
//

import Foundation

protocol ContactDetailViewModelDelegate {
    func getData(user: User?, buttonTitle: String, screenTitle: String)
}

class ContactDetailViewModel {
    private var localStorage: LocalStorage
    private var user: User?
    var contactDetailViewModelDelegate: ContactDetailViewModelDelegate?
    private var isNewContact: Bool = false
    
    init(localStorage: LocalStorage, user: User?) {
        self.localStorage = localStorage
        self.user = user
        if user == nil {
            isNewContact = true
        }
    }
    
    func getInfo() {
        contactDetailViewModelDelegate?.getData(user: user, buttonTitle: isNewContact ? "Salveaza" : "Actualizeaza", screenTitle: isNewContact ? "Adauga contacte" : "Informatii contact")
    }
    
    func updateData(name: String, surename: String, email: String?, phone: String?, completion: @escaping () -> Void) {
        if let user = user {
            localStorage.updateUser(user:  UserInfo(id: user.id, name: "\(name) \(surename)", phoneNumber: phone, status: "active", gender: user.gender, email: email), completion: {
                completion()
            })
        } else {
            let userID = Int16.random(in: 1000...9999)
            addNewUser(user: UserInfo(id: userID, name: "\(name) \(surename)", phoneNumber: phone, status: "active", gender: nil, email: email), completion: {
                completion()
            })
        }
    }
    
    private func addNewUser(user: UserInfo, completion: @escaping () -> Void) {
        if user.id % 2 == 0 {
            if let image = InitialsImageFactory.imageForEvenId(contact: user) {
                localStorage.saveRecord(user: user, imageData: image, completion: { _ in
                    completion()
                })
            }
        } else {
            InitialsImageFactory.imageForOddId(contact: user, completion: { [weak self] (image, user) in
                if let image = image {
                    self?.localStorage.saveRecord(user: user, imageData: image, completion: { _ in
                        completion()
                    })
                }
            })
        }
    }
}
