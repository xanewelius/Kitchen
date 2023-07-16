//
//  NetworkManager.swift
//  Kitchen
//
//  Created by Max Kuzmin on 06.07.2023.
//

import Foundation
import UIKit

final class NetworkManager {
    
    static let shared = NetworkManager()
    
    private let categoriesURL = "https://run.mocky.io/v3/058729bd-1402-4578-88de-265481fd7d54"
    private let dishesURL = "https://run.mocky.io/v3/aba7ecaa-0a70-453b-b62d-0e326c859b3b"
    
    func jsonParsCategories(compeletionHandler: @escaping ([Categories]) -> Void) {
        guard let url = URL(string: categoriesURL) else { return }
        URLSession.shared.dataTask(with: url) { data, response, error in
            if let error = error {
                print(error)
                return
            }
            guard let data = data else { return }
            do {
                let categoriesData = try JSONDecoder().decode(Initial1.self, from: data)
                compeletionHandler(categoriesData.сategories)
            } catch {
                print(error)
            }
            
        }.resume()
    }
    
    func jsonParsDishes(compeletionHandler: @escaping ([Dishes]) -> Void) {
        guard let url = URL(string: dishesURL) else { return }
        URLSession.shared.dataTask(with: url) { data, response, error in
            if let error = error {
                print(error)
                return
            }
            guard let data = data else { return }
            do {
                let dishesData = try JSONDecoder().decode(Initial2.self, from: data)
                compeletionHandler(dishesData.dishes)
            } catch {
                print(error)
            }
            
        }.resume()
    }
}
