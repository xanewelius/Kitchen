//
//  KitchenViewController.swift
//  Kitchen
//
//  Created by Max Kuzmin on 14.07.2023.
//

import UIKit

final class KitchenViewController: UIViewController {
    private let profile = ProfileViewController()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white
        
        let customNavigationBar = CustomNavigationBar()
        let menuButton = customNavigationBar.setUpMenuButton(target: self, action: #selector(setUpMenuButtonTapped))

        self.navigationItem.rightBarButtonItem = menuButton
        self.navigationItem.rightBarButtonItem?.tintColor = .white
    }
    
    lazy var rightImageButton: UIBarButtonItem = {
        let button = UIBarButtonItem(image: UIImage(named: "logotgtg"), style: .done, target: self, action: #selector(setUpMenuButtonTapped))
        return button
    }()
    
    func fetchData(categories: Categories) {
        self.navigationItem.title = "\(categories.name)"
        //        let customNavigationBar = CustomNavigationBar()
        //        self.navigationItem.titleView = customNavigationBar.setImage()
    }
    
    @objc func setUpMenuButtonTapped() {
        self.navigationController?.pushViewController(self.profile, animated: true)
    }
}
