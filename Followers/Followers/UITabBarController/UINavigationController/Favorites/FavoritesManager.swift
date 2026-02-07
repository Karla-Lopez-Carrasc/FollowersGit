//
//  FavoritesManager.swift
//  Followers
//
//  Created by Karla Lopez on 16/01/26.
//

import Foundation

enum FavoritesManager {

    private static let key = "favorites"

    static func getFavorites() -> [Favorite] {
        guard let data = UserDefaults.standard.data(forKey: key) else { return [] }
        do {
            return try JSONDecoder().decode([Favorite].self, from: data)
        } catch {
            return []
        }
    }

    static func save(favorite: Favorite) throws {
        var favorites = getFavorites()

        if favorites.contains(where: { $0.login.lowercased() == favorite.login.lowercased() }) {
            throw GHError.alreadyInFavorites
        }

        favorites.append(favorite)

        let data = try JSONEncoder().encode(favorites)
        UserDefaults.standard.set(data, forKey: key)
    }

    static func remove(favorite: Favorite) {
        var favorites = getFavorites()
        favorites.removeAll { $0.login.lowercased() == favorite.login.lowercased() }

        if let data = try? JSONEncoder().encode(favorites) {
            UserDefaults.standard.set(data, forKey: key)
        }
    }
}
