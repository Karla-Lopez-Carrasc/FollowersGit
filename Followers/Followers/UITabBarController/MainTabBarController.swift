//
//  MainTabBarController.swift
//  Followers
//
//  Created by Karla Lopez on 16/01/26.
//
import UIKit

final class MainTabBarController: UITabBarController {

    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .systemBackground
        setupTabs()
    }

    private func setupTabs() {
        viewControllers = [
            createSearchNav(),
            createFavoritesNav()
        ]
    }

    private func createSearchNav() -> UINavigationController {
        let searchVC = SearchViewController()
        searchVC.title = "Search"
        searchVC.tabBarItem = UITabBarItem(
            title: "Search",
            image: UIImage(systemName: "magnifyingglass"),
            tag: 0
        )

        return UINavigationController(rootViewController: searchVC)
    }

    private func createFavoritesNav() -> UINavigationController {
        let favoritesVC = FavoritesVC()  
        favoritesVC.title = "Favorites"
        favoritesVC.tabBarItem = UITabBarItem(
            title: "Favorites",
            image: UIImage(systemName: "star"),
            tag: 1
        )

        return UINavigationController(rootViewController: favoritesVC)
    }
}
