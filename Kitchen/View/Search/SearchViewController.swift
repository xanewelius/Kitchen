//
//  SearchViewController.swift
//  Kitchen
//
//  Created by Max Kuzmin on 06.07.2023.
//

import UIKit

final class SearchViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        configureView()
    }
}

private extension SearchViewController {
    func configureView() {
        view.backgroundColor = .white
        self.navigationItem.title = "Search"
        let customNavigationBar = CustomNavigationBar()
        self.navigationItem.titleView = customNavigationBar.setImage()
    }
    
    func layout() {
        NSLayoutConstraint.activate([
        
        ])
    }
}
