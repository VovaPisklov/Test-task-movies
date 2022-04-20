//
//  ApiManager.swift
//  Test task movies
//
//  Created by Vova on 17.04.2022.
//

import Foundation

final class NetworkManager {
    static let shared = NetworkManager()
    private init() {}
}

// MARK: - Extension
extension NetworkManager {
    func fetchDataNews(url: String, completion: @escaping (Movies?) -> Void) {
        guard let url = URL(string: url) else { return }
        
        URLSession.shared.dataTask(with: url) { data, _, error in
            guard let data = data else {
                print(error?.localizedDescription ?? "Description not found")
                return
            }
            do {
                let result = try JSONDecoder().decode(Movies.self, from: data)
                DispatchQueue.main.async {
                    completion(result)
                }
            } catch let error {
                print(error)
            }
        }.resume()
    }
}
