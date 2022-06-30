//
//  ContactsViewController.swift
//  CodeChallange
//
//  Created by Andrei Stefanescu on 24.06.2022.
//

import UIKit

class ContactsViewController: UIViewController {
    
    @IBOutlet private weak var addNewButton: UIButton!
    @IBOutlet private weak var titleLabel: UILabel!
    @IBOutlet private weak var tableView: UITableView!
    
    private var items: [User]?
    private var urlSession: URLSession = URLSession()
    var viewModel: ContactsViewModel?
    var delegate: ContactsViewModelDelegate?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        viewModel?.contactsViewModelDelegate = self
        titleLabel.text = "Contacte"
        addNewButton.layer.cornerRadius = 7
        addNewButton.layer.borderColor = UIColor(named: "backgroundColor")?.cgColor
        addNewButton.layer.borderWidth = 2
        tableView.register(UINib(nibName: "ContactsTableViewCell", bundle: nil), forCellReuseIdentifier: "ContactsTableViewCell")
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        viewModel?.fetchData(completion: { [weak self] users in
            self?.items = users
            self?.tableView.reloadData()
        })
    }
    
    @IBAction func didTapAddNewButton(_ sender: Any) {
        goToContactDetail(nil)
    }
    
    private func goToContactDetail(_ user: User?) {
        viewModel?.goToContactDetail(user)
    }
}

extension ContactsViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return items?.count ?? 0
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "ContactsTableViewCell", for: indexPath) as? ContactsTableViewCell else { return UITableViewCell() }
        guard let item = items?[indexPath.row] else { return UITableViewCell() }
        cell.configureCell(user: item)
        return cell
    }
    
    func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        return "CONTACTELE MELE"
    }
}

extension ContactsViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return Constants.TableViewConstants.contactsTableViewCellHeight.rawValue
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        guard let user = items?[indexPath.row] else { return }
        goToContactDetail(user)
        tableView.deselectRow(at: indexPath, animated: true)
    }
}

extension ContactsViewController: ContactsViewModelDelegate {
    func retrieveContacts(users: [User]) {
        items = users
        tableView.reloadData()
    }
}
