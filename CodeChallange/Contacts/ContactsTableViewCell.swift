//
//  ContactsTableViewCell.swift
//  CodeChallange
//
//  Created by Andrei Stefanescu on 24.06.2022.
//

import UIKit

class ContactsTableViewCell: UITableViewCell {
    @IBOutlet private weak var contactImageView: UIImageView!
    @IBOutlet private weak var contactNameLabel: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        contactImageView.layer.cornerRadius = contactImageView.frame.height/2
    }
    
    func configureCell(user: User) {
        guard let userImage = user.userProfileImage else { return }
        contactNameLabel.text = user.name
        if let image = UIImage(data: userImage) {
        contactImageView.image = image
        }
    }
}
