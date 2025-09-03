//
//  Router.swift
//  GithubClient
//
//  Created by Денис Ефименков on 03.09.2025.
//
import UIKit

final class Router {
    let navigationController: UINavigationController
    
    init(navigationController: UINavigationController) {
        self.navigationController = navigationController
    }
    
    func setRootTabBar() {
        let tabBar = UITabBarController()
        
        let searchVC = SearchViewController(router: self)
        let favoritesVC = FavoritesViewController(router: self)
        
        let nav1 = UINavigationController(rootViewController: searchVC)
        nav1.tabBarItem = UITabBarItem(title: "Search", image: UIImage(systemName: "magnifyingglass"), tag: 0)
        
        let nav2 = UINavigationController(rootViewController: favoritesVC)
        nav2.tabBarItem = UITabBarItem(title: "Favorites", image: UIImage(systemName: "star"), tag: 1)
        
        tabBar.viewControllers = [nav1, nav2]
        
        navigationController.setViewControllers([tabBar], animated: false)
    }
    
    func pushMainViewController(username: String) {
        let mainVC = MainViewController(router: self, username: username)
        navigationController.topViewController?.navigationController?.pushViewController(mainVC, animated: true)
    }
}


