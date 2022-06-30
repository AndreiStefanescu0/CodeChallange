//
//  ApiClient.swift
//  CodeChallange
//
//  Created by Andrei Stefanescu on 28.06.2022.
//

import Alamofire

protocol URLSessionProtocol {
    func getContacts(completion: @escaping ([UserInfo]) -> Void)
    func getUsersImage(completion: @escaping (Data?) -> Void)
}

class URLSession: URLSessionProtocol {
    func getContacts(completion: @escaping ([UserInfo]) -> Void) {
        AF.request(Constants.APIConstants.getUsers.rawValue).response { response in
            switch response.result {
            case .success( _):
                let jsonDecoder = JSONDecoder()
                jsonDecoder.keyDecodingStrategy = .convertFromSnakeCase
                if let data = response.data, let contacts = try? jsonDecoder.decode([UserInfo].self, from: data).filter({ $0.status == "active"}) {
                   completion(contacts)
                }
            case .failure(let error):
                print(error)
            }
        }
    }
    
    func getUsersImage(completion: @escaping (Data?) -> Void) {
        AF.request(Constants.APIConstants.getUserImage.rawValue).response { response in
            switch response.result {
            case .success( _):
                if let data = response.data {
                completion(data)
                }
            case .failure(let error):
                print(error)
            }
        }
    }
}
