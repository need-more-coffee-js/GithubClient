//
//  MainViewController.swift
//  GithubClient
//
//  Created by Денис Ефименков on 03.09.2025.
//

import UIKit

class MainViewController: UIViewController, UITableViewDataSource {
    
    private let mainView = MainView()
    private let viewModel: MainViewModel
    var router: Router
    
    private var repositories: [Repository] = []
    
    init(router: Router, username: String = "need-more-coffee-js") {
        self.router = router
        self.viewModel = MainViewModel(username: username)
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) { fatalError("init(coder:) has not been implemented") }
    
    override func loadView() {
        view = mainView
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        mainView.tableView.dataSource = self
        bindViewModel()
        viewModel.loadData()
        setupNavigationController()
    }
    
    private func setupNavigationController(){
        navigationItem.hidesBackButton = true
    }
    
    private func bindViewModel() {
        viewModel.onUserLoaded = { [weak self] user in
            self?.title = user.login
            self?.mainView.bioLabel.text = user.bio ?? "No bio"
            
            if let url = URL(string: user.avatarUrl) {
                URLSession.shared.dataTask(with: url) { data, _, _ in
                    if let data = data {
                        DispatchQueue.main.async {
                            self?.mainView.avatarImageView.image = UIImage(data: data)
                        }
                    }
                }.resume()
            }
        }
        
        viewModel.onReposLoaded = { [weak self] repos in
            self?.repositories = repos
            self?.mainView.tableView.reloadData()
        }
        
        viewModel.onError = { error in
            print("Error:", error)
        }
    }
    
    // MARK: - TableView
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        repositories.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let repo = repositories[indexPath.row]
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath)
        var config = cell.defaultContentConfiguration()
        config.text = repo.name
        config.secondaryText = repo.description
        cell.contentConfiguration = config
        return cell
    }
}
