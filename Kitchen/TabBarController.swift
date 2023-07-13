//
//  TabBarController.swift
//  Nika
//
//  Created by Max Kuzmin on 12.03.2023.
//

import UIKit

final class TabBarController: UITabBarController {
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .lightGray
        setupTabBar()
    }
    
    private func setupTabBar() {
        guard let homeImage = UIImage(systemName: "house") else { return }
        guard let searchImage = UIImage(systemName: "magnifyingglass") else { return }
        guard let bagImage = UIImage(systemName: "bag") else { return }
        guard let profileImage = UIImage(systemName: "person.crop.circle") else { return }
        
        viewControllers = [
            createNavigationController(vc: HomeViewController(), itemName: "Главная", itemImage: homeImage),
            createNavigationController(vc: SearchViewController(), itemName: "Поиск", itemImage: searchImage),
            createNavigationController(vc: BagViewController(), itemName: "Корзина", itemImage: bagImage),
            createNavigationController(vc: ProfileViewController(), itemName: "Аккаунт", itemImage: profileImage)
        ]
    }
    
    private func createNavigationController(vc: UIViewController, itemName: String, itemImage: UIImage) -> UIViewController {
        let navigationViewController = UINavigationController(rootViewController: vc)
        navigationViewController.tabBarItem.title = itemName
        navigationViewController.tabBarItem.image = itemImage
        return navigationViewController
    }
}
