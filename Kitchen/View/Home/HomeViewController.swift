//
//  HomeViewController.swift
//  Kitchen
//
//  Created by Max Kuzmin on 06.07.2023.
//

import UIKit
import CoreLocation

final class HomeViewController: UIViewController {
    
    private let kitchen = KitchenViewController()
    private let collectionInsets = UIEdgeInsets(top: 8, left: 5, bottom: 5, right: 0)
    private var categories: [Categories] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()
        //setupLocation()
        configureView()
        fetchData()
    }
    
    private func fetchData() {
        NetworkManager.shared.jsonParsCategories { categoriesData in
            DispatchQueue.main.async {
                self.categories = categoriesData
                self.collectionView.reloadData() // обновление таблицы после получения данных
            }
        }
    }
    
    private let collectionView: UICollectionView = {
        let layout = UICollectionViewFlowLayout()
        layout.scrollDirection = .vertical
        layout.itemSize = CGSize(width: 343, height: 148)
        
        let collectionView = UICollectionView(frame: .zero, collectionViewLayout: layout)
        collectionView.register(HomeCollectionViewCell.self, forCellWithReuseIdentifier: "Cell")
        collectionView.backgroundColor = .systemBackground
        collectionView.translatesAutoresizingMaskIntoConstraints = false
        return collectionView
    }()
}

private extension HomeViewController {
    func configureView() {
        view.backgroundColor = .white
        
        let customNavigationBar = CustomNavigationBar()
        self.navigationItem.titleView = customNavigationBar.setTitle()
        self.navigationItem.rightBarButtonItem = customNavigationBar.setUpMenuButton()
        self.navigationItem.rightBarButtonItem?.tintColor = .white
        
        collectionView.delegate = self
        collectionView.dataSource = self
        
        view.addSubview(collectionView)
        
        layout()
    }
    
    func layout() {
        NSLayoutConstraint.activate([
            collectionView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 0),
            collectionView.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: 0),
            collectionView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 14),
            collectionView.bottomAnchor.constraint(equalTo: view.bottomAnchor, constant: 0),
        ])
    }
}

extension HomeViewController: UICollectionViewDelegate, UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return categories.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "Cell", for: indexPath) as? HomeCollectionViewCell else { return UICollectionViewCell() }
        
        let category = categories[indexPath.item]
        cell.configure(with: category)
        
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let category = categories[indexPath.item]
        kitchen.fetchData(categories: category)
        collectionView.deselectItem(at: indexPath, animated: true)
        self.navigationController?.pushViewController(self.kitchen, animated: true)
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAt section: Int) -> UIEdgeInsets {
        collectionInsets
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        collectionInsets.top
    }
}

// MARK: - CLLocation
//extension HomeViewController: CLLocationManagerDelegate {
//    private func setupLocation() {
//        let locationManager = CLLocationManager()
//        locationManager.delegate = self
//        locationManager.desiredAccuracy = kCLLocationAccuracyBest
//        locationManager.requestWhenInUseAuthorization()
//        locationManager.startUpdatingLocation()
//    }
//
//    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
//        guard let first = locations.first else { return }
//        let lat = String(first.coordinate.latitude)
//        let lon = String(first.coordinate.longitude)
//        print("agag")
//    }
//}
