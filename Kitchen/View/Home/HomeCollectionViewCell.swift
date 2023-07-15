//
//  HomeCollectionViewCell.swift
//  Kitchen
//
//  Created by Max Kuzmin on 13.07.2023.
//

import UIKit
import Nuke

class HomeCollectionViewCell: UICollectionViewCell {
    
    // MARK: - Properties
    private let titleLabel: UILabel = {
        let label = UILabel()
        // Настройте внешний вид метки по вашему выбору
        label.textAlignment = .center
        label.textColor = .black
        label.font = UIFont.boldSystemFont(ofSize: 20)
        label.numberOfLines = 2
        label.textAlignment = .left
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    let imageView: UIImageView = {
        let imageView = UIImageView()
        imageView.clipsToBounds = true
        imageView.layer.cornerRadius = 10
        imageView.contentMode = .scaleAspectFill
        imageView.translatesAutoresizingMaskIntoConstraints = false
        return imageView
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
    func configure(with category: Categories) {
        let formattedText = category.name.replacingOccurrences(of: " и ", with: "\nи ")
        titleLabel.text = formattedText
        let url = category.image_url
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
private extension HomeCollectionViewCell {
    private func configureView() {
        contentView.addSubview(imageView)
        contentView.addSubview(titleLabel)
        
        // Расположение метки внутри ячейки
        NSLayoutConstraint.activate([
            titleLabel.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 12),
            titleLabel.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 16),
            titleLabel.widthAnchor.constraint(equalToConstant: 191),
            
            imageView.centerYAnchor.constraint(equalTo: contentView.centerYAnchor),
            imageView.centerXAnchor.constraint(equalTo: contentView.centerXAnchor),
            imageView.heightAnchor.constraint(equalToConstant: 148),
            imageView.widthAnchor.constraint(equalToConstant: 343)
        ])
    }
}
