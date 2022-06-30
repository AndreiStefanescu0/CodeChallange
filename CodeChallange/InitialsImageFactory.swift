//
//  InitialsImageFactory.swift
//  CodeChallange
//
//  Created by Andrei Stefanescu on 26.06.2022.
//

import UIKit

class InitialsImageFactory: NSObject {
    
    class func imageForEvenId(contact: UserInfo) -> Data? {
            let frame = CGRect(x: 0, y: 0, width: 46, height: 46)
            let nameLabel = UILabel(frame: frame)
            nameLabel.textAlignment = .center
            nameLabel.backgroundColor = UIColor(named: "initialsImageBackground")
            nameLabel.textColor = .white
            nameLabel.font = UIFont.boldSystemFont(ofSize: 17)
            var initials = ""
            let initialsArray = contact.name.components(separatedBy: " ")
            
            if let firstWord = initialsArray.first {
                if let firstLetter = firstWord.first {
                    initials += String(firstLetter).capitalized
                }
            }
            if initialsArray.count > 1 {
                if let lastLetter = initialsArray[1].first {
                    initials += String(lastLetter).capitalized
                }
            }
            nameLabel.text = initials
            UIGraphicsBeginImageContext(frame.size)
            if let currentContext = UIGraphicsGetCurrentContext() {
                nameLabel.layer.render(in: currentContext)
                guard let imageData = UIGraphicsGetImageFromCurrentImageContext()?.pngData() else { return nil }
                return imageData
            }
        return nil
    }
    
    class func imageForOddId(contact: UserInfo, completion: @escaping (Data?, UserInfo) -> Void) {
        URLSession().getUsersImage(completion: { imageData in
            completion(imageData, contact)
        })
    }
}

