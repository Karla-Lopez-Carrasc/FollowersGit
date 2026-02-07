//
//  NetworkManager.swift
//  Followers
//
//  Created by Karla Lopez on 16/01/26.
//

import Foundation

final class NetworkManager {

    static let shared = NetworkManager()
    private let baseURL = "https://api.github.com/users/"

    private init() {}

    func fetchFollowers(
        username: String,
        completion: @escaping (Result<[FollowerDTO], GHError>) -> Void
    ) {

        let endpoint = baseURL + "\(username)/followers"

        guard let url = URL(string: endpoint) else {
            completion(.failure(.invalidURL))
            return
        }

        let task = URLSession.shared.dataTask(with: url) { data, response, error in

            if error != nil {
                completion(.failure(.unableToComplete))
                return
            }

            guard let response = response as? HTTPURLResponse else {
                completion(.failure(.invalidResponse))
                return
            }

            switch response.statusCode {
            case 200:
                break
            case 404:
                completion(.failure(.userNotFound))
                return
            default:
                completion(.failure(.invalidResponse))
                return
            }

            guard let data = data else {
                completion(.failure(.invalidData))
                return
            }

            do {
                let decoder = JSONDecoder()
                let followers = try decoder.decode([FollowerDTO].self, from: data)
                completion(.success(followers))
            } catch {
                completion(.failure(.invalidData))
            }
        }

        task.resume()
    }
}
