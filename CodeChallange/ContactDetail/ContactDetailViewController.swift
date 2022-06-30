//
//  ContactDetailViewController.swift
//  CodeChallange
//
//  Created by Andrei Stefanescu on 24.06.2022.
//

import Foundation
import UIKit

class ContactDetailViewController: UIViewController {
    
    @IBOutlet private weak var saveButton: UIButton!
    @IBOutlet private weak var nameView: UIView!
    @IBOutlet private weak var surenameView: UIView!
    @IBOutlet private weak var phoneView: UIView!
    @IBOutlet private weak var emailView: UIView!
    @IBOutlet private weak var nameTextField: UITextField!
    @IBOutlet private weak var surenameTextField: UITextField!
    @IBOutlet private weak var phoneTextField: UITextField!
    @IBOutlet private weak var emailTextField: UITextField!
    @IBOutlet private weak var titleLabel: UILabel!
    
    private var user: User?
    var viewModel: ContactDetailViewModel?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        viewModel?.contactDetailViewModelDelegate = self
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        setupViews()
        viewModel?.getInfo()
    }
    
    private func setupViews() {
        nameView.layer.cornerRadius = 12
        surenameView.layer.cornerRadius = 12
        phoneView.layer.cornerRadius = 12
        emailView.layer.cornerRadius = 12
        saveButton.layer.cornerRadius = 12
    }
    
    @IBAction func didTapSaveButton(_ sender: Any) {
        if let name = nameTextField.text, let surename = surenameTextField.text, !name.isEmpty, !surename.isEmpty {
            viewModel?.updateData(name: name, surename: surename, email: emailTextField.text, phone: phoneTextField.text ?? "", completion: {
                self.navigationController?.popViewController(animated: true)
            })
        }
    }
}

extension ContactDetailViewController: ContactDetailViewModelDelegate {
    func getData(user: User?, buttonTitle: String, screenTitle: String) {
        if let user = user {
            emailTextField.text = user.email
            phoneTextField.text = user.phoneNumber
            var names = user.name?.components(separatedBy: " ")
            nameTextField.text = names?.removeFirst()
            surenameTextField.text = names?.joined(separator: " ")
        }
        titleLabel.text = screenTitle
        saveButton.setTitle(buttonTitle, for: .normal)
    }
}
