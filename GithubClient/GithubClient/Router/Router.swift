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
    
    private func push(controller: UIViewController){
        navigationController.pushViewController(controller, animated: true)
    }
    
    func pushSearchViewController() {
        let searchVC = SearchViewController(router: self)
        push(controller: searchVC)
    }
    
    func pushMainViewController(username: String) {
        let mainVC = MainViewController(router: self, username: username)
        push(controller: mainVC)
    }
}

