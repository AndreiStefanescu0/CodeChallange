//
//  AppInitiater.swift
//  CodeChallange
//
//  Created by Andrei Stefanescu on 28.06.2022.
//

import UIKit


class AppInitiater {
    
    let window: UIWindow
    var rootViewController: UINavigationController
    
    init(window: UIWindow) {
        self.window = window
        rootViewController = UINavigationController()
        rootViewController.setNavigationBarHidden(true, animated: false)
        let storyboard = UIStoryboard.init(name: "Main", bundle: .main)
        guard let contactVC = storyboard.instantiateViewController(withIdentifier: "ContactsViewController") as? ContactsViewController else { return }
        let localStorage = LocalStorage()
        let urlSession = URLSession()
        let contactViewModel = ContactsViewModel(localStorage: localStorage, contactsNavigationDelegate: self, urlSession: urlSession)
        contactVC.viewModel = contactViewModel
        rootViewController.pushViewController(contactVC, animated: false)
    }
    
    func start() {
        window.rootViewController = rootViewController
        window.makeKeyAndVisible()
    }
}

extension AppInitiater: ContactsNavigationDelegate {
    func goToDetailScreen(user: User?, localStorage: LocalStorage) {
        let storyboard = UIStoryboard.init(name: "Main", bundle: .main)
        guard let contactDetailVC = storyboard.instantiateViewController(withIdentifier: "ContactDetailViewController") as? ContactDetailViewController else { return }
        let contactDetailViewModel = ContactDetailViewModel(localStorage: localStorage, user: user)
        contactDetailVC.viewModel = contactDetailViewModel
        rootViewController.pushViewController(contactDetailVC, animated: true)
    }
}
