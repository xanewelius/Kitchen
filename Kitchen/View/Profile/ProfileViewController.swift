//
//  ProfileViewController.swift
//  Kitchen
//
//  Created by Max Kuzmin on 06.07.2023.
//

import UIKit

final class ProfileViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        configureView()
    }
}

private extension ProfileViewController {
    func configureView() {
        view.backgroundColor = .white
        self.navigationItem.title = "Profile"
        let customNavigationBar = CustomNavigationBar()
    }
    
    func layout() {
        NSLayoutConstraint.activate([
        
        ])
    }
}
