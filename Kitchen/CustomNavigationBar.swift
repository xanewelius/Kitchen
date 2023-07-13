//
//  CustomNavigationBar.swift
//  Kitchen
//
//  Created by Max Kuzmin on 13.07.2023.
//

import UIKit
import CoreLocation

final class CustomNavigationBar: UIViewController {
    
    private let navigationView = UIView(frame: CGRect(x: 0, y: 0, width: 343, height: 50))
    
    func setTitle() -> UIView {
        let titleLabel = UILabel(frame: CGRect(x: 28, y: 0, width: 0, height: 0))
        titleLabel.backgroundColor = UIColor.clear
        titleLabel.textColor = .black
        titleLabel.font = UIFont.boldSystemFont(ofSize: 18)
        titleLabel.text = "Санкт-Петербург"
        titleLabel.sizeToFit()
        
        let subtitleLabel = UILabel(frame: CGRect(x: 28, y: 26, width: 0, height: 0))
        subtitleLabel.backgroundColor = UIColor.clear
        subtitleLabel.textColor = .gray
        subtitleLabel.font = UIFont.systemFont(ofSize: 14)
        subtitleLabel.text = "12 Августа, 2023"
        subtitleLabel.sizeToFit()
        
        let locationImage = UIImage(named: "Icons")
        let locationImageView = UIImageView(image: locationImage)
        locationImageView.tintColor = .black
        locationImageView.frame = CGRect(x: 0, y: 0, width: 24, height: 24) // Размер изображения и его позиция
        

        navigationView.addSubview(locationImageView)
        navigationView.addSubview(titleLabel)
        navigationView.addSubview(subtitleLabel)
        
        return navigationView
    }
    
    func setImage() -> UIView {
        let image = UIImage(named: "image_name")
        let imageView = UIImageView(image: image)
        imageView.frame = CGRect(x: navigationView.frame.width - 44, y: 0, width: 44, height: 44) // Размер изображения и его позиция
        
        navigationView.addSubview(imageView)
        
        return navigationView
    }
}


