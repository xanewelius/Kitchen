//
//  BagViewController.swift
//  Kitchen
//
//  Created by Max Kuzmin on 06.07.2023.
//

import UIKit

final class BagViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        configureView()
    }
}

private extension BagViewController {
    func configureView() {
        view.backgroundColor = .white
        //self.navigationItem.title = "Bag"
        let customNavigationBar = CustomNavigationBar()
        self.navigationItem.titleView = customNavigationBar.setTitle()
        self.navigationItem.titleView = customNavigationBar.setImage()
    }
    
    func layout() {
        NSLayoutConstraint.activate([
        
        ])
    }
}
