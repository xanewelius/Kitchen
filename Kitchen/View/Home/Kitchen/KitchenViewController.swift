//
//  KitchenViewController.swift
//  Kitchen
//
//  Created by Max Kuzmin on 14.07.2023.
//

import UIKit

final class KitchenViewController: UIViewController {
    
    //private let kitchenViewCell = KitchenCollectionViewCell()
    private let collectionInsets = UIEdgeInsets(top: 0, left: 0, bottom: 0, right: 0)
    private var dishes: [Dishes] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()
        configureView()
    }
    
    private let dishesCollectionView: UICollectionView = {
        let layout = UICollectionViewFlowLayout()
        layout.scrollDirection = .vertical
        layout.itemSize = CGSize(width: 109, height: 145)
        layout.sectionInset = UIEdgeInsets(top: 14, left: 25, bottom: 0, right: 25) // Добавлены отступы слева и справа
        layout.minimumInteritemSpacing = 8 // Расстояние между ячейками по горизонтали
        //layout.minimumLineSpacing = 8 // Расстояние между ячейками по вертикали
        
        let collectionView = UICollectionView(frame: .zero, collectionViewLayout: layout)
        collectionView.register(DishesCollectionViewCell.self, forCellWithReuseIdentifier: "Cell")
        collectionView.backgroundColor = .systemBackground
        collectionView.translatesAutoresizingMaskIntoConstraints = false
        return collectionView
    }()
    
    private let menuCollectionView: UICollectionView = {
        let layout = UICollectionViewFlowLayout()
        layout.scrollDirection = .horizontal
        layout.itemSize = CGSize(width: 100, height: 30)
        layout.sectionInset = UIEdgeInsets(top: 0, left: 10, bottom: 0, right: 10) // Добавлены отступы слева и справа
        layout.minimumInteritemSpacing = 8 // Расстояние между ячейками по горизонтали
        //layout.minimumLineSpacing = 8 // Расстояние между ячейками по вертикали
        
        let collectionView = UICollectionView(frame: .zero, collectionViewLayout: layout)
        collectionView.register(DishesCollectionViewCell.self, forCellWithReuseIdentifier: "Cell")
        collectionView.backgroundColor = .systemBackground
        collectionView.translatesAutoresizingMaskIntoConstraints = false
        return collectionView
    }()
    
    func fetchData(categories: Categories) {
        self.navigationItem.title = "\(categories.name)"
        NetworkManager.shared.jsonParsDishes { dishesData in
            DispatchQueue.main.async {
                self.dishes = dishesData
                self.dishesCollectionView.reloadData() // обновление таблицы после получения данных
            }
        }
    }
}

private extension KitchenViewController {
    func configureView() {
        view.backgroundColor = .white
        
        let customNavigationBar = CustomNavigationBar()
        self.navigationItem.rightBarButtonItem = customNavigationBar.setUpMenuButton()
        
        dishesCollectionView.delegate = self
        dishesCollectionView.dataSource = self
        
        view.addSubview(dishesCollectionView)
        
        layout()
    }
    
    func layout() {
        NSLayoutConstraint.activate([
            dishesCollectionView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 0),
            dishesCollectionView.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: 0),
            dishesCollectionView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 14),
            dishesCollectionView.bottomAnchor.constraint(equalTo: view.bottomAnchor, constant: 0),
        ])
    }
}

extension KitchenViewController: UICollectionViewDelegate, UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return dishes.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "Cell", for: indexPath) as? DishesCollectionViewCell else { return UICollectionViewCell() }
        
        let dishes = dishes[indexPath.item]
        cell.configure(with: dishes)
        
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        //let dishes = dishes[indexPath.item]
        //dishes.fetchData(categories: category)
        //collectionView.deselectItem(at: indexPath, animated: true)
        //self.navigationController?.pushViewController(self.dishes, animated: true)
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAt section: Int) -> UIEdgeInsets {
        collectionInsets
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        collectionInsets.top
    }
}
