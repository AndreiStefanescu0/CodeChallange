//
//  ContactsViewModel.swift
//  CodeChallange
//
//  Created by Andrei Stefanescu on 24.06.2022.
//
import Alamofire
import Foundation

class ContactsViewModel {
    
    func getContacts() {
        AF.request("https://gorest.co.in/public/v2/users").response { response in
            print(response)
        }
    }
}
