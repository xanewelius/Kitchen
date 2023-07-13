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
    
    let baseURL = "https://run.mocky.io/v3/058729bd-1402-4578-88de-265481fd7d54"
    
    func jsonPars(compeletionHandler: @escaping ([Categories]) -> Void) {
        guard let url = URL(string: baseURL) else { return }
        URLSession.shared.dataTask(with: url) { data, response, error in
            if let error = error {
                print(error)
                return
            }
            guard let data = data else { return }
            do {
                let categoriesData = try JSONDecoder().decode(Initial.self, from: data)
                compeletionHandler(categoriesData.сategories)
            } catch {
                print(error)
            }
            
        }.resume()
    }
}
