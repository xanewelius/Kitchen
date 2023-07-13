//
//  Model.swift
//  Kitchen
//
//  Created by Max Kuzmin on 06.07.2023.
//

import Foundation

struct Initial: Codable {
    let сategories: [Categories]
}

struct Categories: Codable {
    let id: Int
    let name: String
    let image_url: String
}
