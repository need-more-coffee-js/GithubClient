//
//  GitHubService.swift
//  GithubClient
//
//  Created by Денис Ефименков on 03.09.2025.
//

import Foundation

final class GitHubService {
    private let baseURL = "https://api.github.com/users/"
    private let session = URLSession.shared
    
    func fetchUser(username: String, completion: @escaping (Result<User, Error>) -> Void) {
        guard let url = URL(string: baseURL + username) else { return }
        session.dataTask(with: url) { data, _, error in
            if let error = error { completion(.failure(error)); return }
            guard let data = data else { return }
            do {
                let user = try JSONDecoder().decode(User.self, from: data)
                completion(.success(user))
            } catch {
                completion(.failure(error))
            }
        }.resume()
    }
    
    func fetchRepos(username: String, completion: @escaping (Result<[Repository], Error>) -> Void) {
        guard let url = URL(string: baseURL + username + "/repos") else { return }
        session.dataTask(with: url) { data, _, error in
            if let error = error { completion(.failure(error)); return }
            guard let data = data else { return }
            do {
                let repos = try JSONDecoder().decode([Repository].self, from: data)
                completion(.success(repos))
            } catch {
                completion(.failure(error))
            }
        }.resume()
    }
}

