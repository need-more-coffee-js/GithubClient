//
//  MainViewModel.swift
//  GithubClient
//
//  Created by Денис Ефименков on 03.09.2025.
//

import Foundation

final class MainViewModel {
    private let service = GitHubService()
    private let username: String
    
    var onUserLoaded: ((User) -> Void)?
    var onReposLoaded: (([Repository]) -> Void)?
    var onError: ((String) -> Void)?
    
    init(username: String) {
        self.username = username
    }
    
    func loadData() {
        service.fetchUser(username: username) { [weak self] result in
            DispatchQueue.main.async {
                switch result {
                case .success(let user):
                    self?.onUserLoaded?(user)
                case .failure(let error):
                    self?.onError?(error.localizedDescription)
                }
            }
        }
        
        service.fetchRepos(username: username) { [weak self] result in
            DispatchQueue.main.async {
                switch result {
                case .success(let repos):
                    self?.onReposLoaded?(repos)
                case .failure(let error):
                    self?.onError?(error.localizedDescription)
                }
            }
        }
    }
}

