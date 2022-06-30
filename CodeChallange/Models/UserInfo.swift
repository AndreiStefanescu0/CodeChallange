//
//  UserInfo.swift
//  CodeChallange
//
//  Created by Andrei Stefanescu on 24.06.2022.
//

import Foundation

struct UserInfo: Decodable {
    let id: Int16
    let name: String
    let phoneNumber: String?
    let status: String?
    let gender: String?
    let email: String?
}
