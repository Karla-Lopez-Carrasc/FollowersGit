//
//  GitHubAPI.swift
//  Followers
//
//  Created by Karla Lopez on 10/01/26.
//

import Foundation

enum GitHubAPI {
    static let baseURL = "https://api.github.com"

    static func followersURL(username: String, perPage: Int = 100, page: Int = 1) -> URL? {
        var comps = URLComponents(string: "\(baseURL)/users/\(username)/followers")
        comps?.queryItems = [
            URLQueryItem(name: "per_page", value: "\(perPage)"),
            URLQueryItem(name: "page", value: "\(page)")
        ]
        return comps?.url
    }
}
