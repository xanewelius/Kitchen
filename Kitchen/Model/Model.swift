//
//  Model.swift
//  Kitchen
//
//  Created by Max Kuzmin on 06.07.2023.
//

import Foundation

struct Initial1: Codable {
    let сategories: [Categories]
}

struct Initial2: Codable {
    let dishes: [Dishes]
}

struct Categories: Codable {
    let id: Int
    let name: String
    let image_url: String
}

struct Dishes: Codable {
    let id: Int
    let name: String
    let price: Int
    let weight: Int
    let description: String
    let image_url: String
    let tegs: [String]
}

