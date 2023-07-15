//
//  KitchenCollectionViewCell.swift
//  Kitchen
//
//  Created by Max Kuzmin on 15.07.2023.
//

import UIKit
import Nuke

class DishesCollectionViewCell: UICollectionViewCell {
    
    // MARK: - Properties
    let titleLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont.systemFont(ofSize: 13)
        label.translatesAutoresizingMaskIntoConstraints = false
        label.numberOfLines = 2
        return label
    }()
    
    let imageView: UIImageView = {
        let imageView = UIImageView()
        imageView.clipsToBounds = true
        imageView.layer.cornerRadius = 10
        imageView.contentMode = .scaleAspectFit
        imageView.backgroundColor = .systemGray6
        imageView.translatesAutoresizingMaskIntoConstraints = false
        return imageView
    }()
    
    let backgroundImageView: UIView = {
        let view = UIView()
        view.layer.cornerRadius = 10
        view.backgroundColor = .systemGray6
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    // MARK: - Initialization
    override init(frame: CGRect) {
        super.init(frame: frame)
        configureView()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: - Configuration
    func configure(with dishes: Dishes) {
        titleLabel.text = dishes.name
        let url = dishes.image_url
        async {
            do {
                let image = try await loadImage(url: url)
                self.imageView.image = image
            } catch {
                print(error)
                self.imageView.image = UIImage(named: "3")
            }
        }
    }
    
    func loadImage(url: String) async throws -> UIImage {
        let task = Task.init(priority: .high) {
            let task = ImagePipeline.shared.imageTask(with: URL(string: url)!)
            for await progress in task.progress {
                print("Updated progress: ", progress)
            }
            return try await task.image
        }
        return try await task.value
    }
}

// MARK: - Layout
private extension DishesCollectionViewCell {
    func configureView() {
        contentView.layer.masksToBounds = true
        //contentView.backgroundColor = .systemGray6
        contentView.addSubview(backgroundImageView)
        contentView.addSubview(imageView)
        contentView.addSubview(titleLabel)
        layout()
    }
    
    func layout() {
        NSLayoutConstraint.activate([
            backgroundImageView.centerXAnchor.constraint(equalTo: contentView.centerXAnchor),
            backgroundImageView.topAnchor.constraint(equalTo: contentView.topAnchor),
            backgroundImageView.widthAnchor.constraint(equalToConstant: 109),
            backgroundImageView.heightAnchor.constraint(equalToConstant: 109),
            
            imageView.centerXAnchor.constraint(equalTo: backgroundImageView.centerXAnchor),
            imageView.centerYAnchor.constraint(equalTo: backgroundImageView.centerYAnchor),
            imageView.widthAnchor.constraint(equalToConstant: 90),
            imageView.heightAnchor.constraint(equalToConstant: 90),
            
            titleLabel.topAnchor.constraint(equalTo: backgroundImageView.bottomAnchor, constant: 5),
            titleLabel.leadingAnchor.constraint(equalTo: contentView.leadingAnchor),
            titleLabel.trailingAnchor.constraint(equalTo: contentView.trailingAnchor),
            titleLabel.widthAnchor.constraint(equalToConstant: 109)
        ])
    }
}
