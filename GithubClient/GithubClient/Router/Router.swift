//
//  Router.swift
//  GithubClient
//
//  Created by Денис Ефименков on 03.09.2025.
//

import UIKit

final class Router{
    let navigationController: UINavigationController
    
    init(navigationController: UINavigationController) {
        self.navigationController = navigationController
    }
    
    private func push(controller: UIViewController){
        navigationController.pushViewController(controller, animated: true)
    }
    
    private func pop(){
        navigationController.popViewController(animated: true)
    }
    
    func pushMainViewController(){
        let mainVC = MainViewController(router: self)
        push(controller: mainVC)
    }
}
