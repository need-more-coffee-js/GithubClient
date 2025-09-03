//
//  ViewController.swift
//  GithubClient
//
//  Created by Денис Ефименков on 03.09.2025.
//

import UIKit

class WelcomeViewController: UIViewController {
    
    private let welcomeView = WelcomeView()
    var router: Router
    
    init(router: Router) {
        self.router = router
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setup()
        layout()
    }
    
    private func setup(){
        view.addSubview(welcomeView)
        welcomeView.didTapStart = { [weak self] in
            self?.router.pushSearchViewController()
        }
    }

    
    private func layout(){
        welcomeView.pinToEdges(of: view)
    }
}

