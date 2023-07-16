//
//  ModalViewController.swift
//  Kitchen
//
//  Created by Max Kuzmin on 15.07.2023.
//

import UIKit
import Nuke

class DishViewController: UIViewController {
    
    private var isTapped = false
    
    // MARK: - Properties
    private let containerView: UIView = {
        let view = UIView()
        view.backgroundColor = .white
        view.layer.cornerRadius = 10
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    private let dishImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.contentMode = .scaleAspectFit
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
    
    private let dishNameLabel: UILabel = {
        let label = UILabel()
        label.font = .boldSystemFont(ofSize: 14)
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    private let dishPriceLabel: UILabel = {
        let label = UILabel()
        label.font = .systemFont(ofSize: 12)
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    private let dishWeightLabel: UILabel = {
        let label = UILabel()
        label.textColor = .systemGray2
        label.font = .systemFont(ofSize: 12)
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    private let dishDescriptionLabel: UILabel = {
        let label = UILabel()
        label.font = .systemFont(ofSize: 8.5)
        label.numberOfLines = 7
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    private let closeButton: UIButton = {
        var configuration = UIButton.Configuration.filled()
        configuration.baseBackgroundColor = .white
        configuration.baseForegroundColor = .black
        configuration.cornerStyle = .small
        configuration.buttonSize = .mini
        
        let button = UIButton(configuration: configuration)
        button.setImage(UIImage(systemName: "xmark"), for: .normal)
        button.contentMode = .scaleToFill
        button.contentHorizontalAlignment = .fill
        button.contentVerticalAlignment = .fill
        button.tintColor = .black
        button.translatesAutoresizingMaskIntoConstraints = false
        button.addTarget(self, action: #selector(closeButtonTapped), for: .touchUpInside)
        return button
    }()
    
    private let favoriteButton: UIButton = {
        var configuration = UIButton.Configuration.filled()
        configuration.baseBackgroundColor = .white
        configuration.baseForegroundColor = .black
        configuration.cornerStyle = .small
        configuration.buttonSize = .mini
        
        let button = UIButton(configuration: configuration)
        button.setImage(UIImage(systemName: "heart"), for: .normal)
        button.contentMode = .scaleAspectFill
        button.contentHorizontalAlignment = .fill
        button.contentVerticalAlignment = .fill
        button.tintColor = .black
        button.translatesAutoresizingMaskIntoConstraints = false
        button.addTarget(self, action: #selector(favoriteButtonTapped), for: .touchUpInside)
        return button
    }()
    
    private let addBagButton: UIButton = {
        var configuration = UIButton.Configuration.filled()
        configuration.title = "Добавить в корзину"
        configuration.buttonSize = .medium
        configuration.attributedTitle?.font = .systemFont(ofSize: 16)
        
        let button = UIButton(configuration: configuration)
        button.translatesAutoresizingMaskIntoConstraints = false
        button.layer.cornerRadius = 10
        button.clipsToBounds = true
        button.addTarget(self, action: #selector(addBagButtonTapped), for: .touchUpInside)
        return button
    }()
    
    // MARK: - Initialization
    override func viewDidLoad() {
        super.viewDidLoad()
        configureView()
    }
    
    // MARK: - Configuration
    func configure(with dish: Dishes) {
        dishNameLabel.text = dish.name
        dishPriceLabel.text = "\(dish.price) ₽ · "
        dishWeightLabel.text = "\(dish.weight)г"
        dishDescriptionLabel.text = dish.description
        let url = dish.image_url
        async {
            do {
                let image = try await loadImage(url: url)
                self.dishImageView.image = image
            } catch {
                print(error)
                self.dishImageView.image = UIImage(named: "3")
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
private extension DishViewController {
    
    @objc func closeButtonTapped() {
        dismiss(animated: true, completion: nil)
    }
    
    @objc func favoriteButtonTapped() {
        if isTapped {
            isTapped = false
            favoriteButton.setImage(UIImage(systemName: "heart"), for: .normal)
        } else {
            isTapped = true
            favoriteButton.setImage(UIImage(systemName: "heart.fill"), for: .normal)
        }
    }
    
    @objc func addBagButtonTapped() {
        dismiss(animated: true, completion: nil)
    }
    
    func configureView() {
        view.backgroundColor = UIColor.black.withAlphaComponent(0.6)
        view.isOpaque = false
        view.addSubview(containerView)
        containerView.addSubview(backgroundImageView)
        containerView.addSubview(dishImageView)
        containerView.addSubview(dishNameLabel)
        containerView.addSubview(dishPriceLabel)
        containerView.addSubview(dishWeightLabel)
        containerView.addSubview(dishDescriptionLabel)
        containerView.addSubview(addBagButton)
        containerView.addSubview(closeButton)
        containerView.addSubview(favoriteButton)
        
        layout()
    }
    
    func layout() {
        NSLayoutConstraint.activate([
            containerView.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            containerView.centerYAnchor.constraint(equalTo: view.centerYAnchor),
            containerView.widthAnchor.constraint(equalToConstant: 343),
            containerView.heightAnchor.constraint(equalToConstant: 446),
            
            backgroundImageView.centerXAnchor.constraint(equalTo: containerView.centerXAnchor),
            backgroundImageView.topAnchor.constraint(equalTo: containerView.topAnchor, constant: 16),
            backgroundImageView.widthAnchor.constraint(equalToConstant: 311),
            backgroundImageView.heightAnchor.constraint(equalToConstant: 232),
            
            dishImageView.centerXAnchor.constraint(equalTo: backgroundImageView.centerXAnchor),
            dishImageView.centerYAnchor.constraint(equalTo: backgroundImageView.centerYAnchor),
            dishImageView.widthAnchor.constraint(equalToConstant: 200),
            dishImageView.heightAnchor.constraint(equalToConstant: 200),
            
            closeButton.topAnchor.constraint(equalTo: backgroundImageView.topAnchor, constant: 8),
            closeButton.trailingAnchor.constraint(equalTo: backgroundImageView.trailingAnchor, constant: -8),
            closeButton.widthAnchor.constraint(equalToConstant: 40),
            closeButton.heightAnchor.constraint(equalToConstant: 40),
            
            favoriteButton.topAnchor.constraint(equalTo: backgroundImageView.topAnchor, constant: 8),
            favoriteButton.trailingAnchor.constraint(equalTo: closeButton.leadingAnchor, constant: -8),
            favoriteButton.widthAnchor.constraint(equalToConstant: 40),
            favoriteButton.heightAnchor.constraint(equalToConstant: 40),
            
            dishNameLabel.topAnchor.constraint(equalTo: backgroundImageView.bottomAnchor, constant: 8),
            dishNameLabel.leadingAnchor.constraint(equalTo: containerView.leadingAnchor, constant: 16),
            dishNameLabel.trailingAnchor.constraint(equalTo: containerView.trailingAnchor, constant: -16),
            
            dishPriceLabel.topAnchor.constraint(equalTo: dishNameLabel.bottomAnchor, constant: 8),
            dishPriceLabel.leadingAnchor.constraint(equalTo: containerView.leadingAnchor, constant: 16),
            
            dishWeightLabel.topAnchor.constraint(equalTo: dishNameLabel.bottomAnchor, constant: 8),
            dishWeightLabel.leadingAnchor.constraint(equalTo: dishPriceLabel.trailingAnchor, constant: 0),
            dishWeightLabel.trailingAnchor.constraint(equalTo: containerView.trailingAnchor, constant: -16),
            
            dishDescriptionLabel.topAnchor.constraint(equalTo: dishPriceLabel.bottomAnchor, constant: 8),
            dishDescriptionLabel.leadingAnchor.constraint(equalTo: containerView.leadingAnchor, constant: 16),
            dishDescriptionLabel.trailingAnchor.constraint(equalTo: containerView.trailingAnchor, constant: -16),
            
            addBagButton.bottomAnchor.constraint(equalTo: containerView.bottomAnchor, constant: -16),
            addBagButton.heightAnchor.constraint(equalToConstant: 48),
            addBagButton.leadingAnchor.constraint(equalTo: containerView.leadingAnchor, constant: 16),
            addBagButton.trailingAnchor.constraint(equalTo: containerView.trailingAnchor, constant: -16),
        ])
    }
}

