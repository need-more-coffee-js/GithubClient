//
//  FavoritesManager.swift
//  GithubClient
//
//  Created by Денис Ефименков on 03.09.2025.
//

import Foundation

final class FavoritesManager {
    static let shared = FavoritesManager()
    
    private let key = "favoriteUsers"
    private init() {}
    
    var favorites: [String] {
        get {
            UserDefaults.standard.stringArray(forKey: key) ?? []
        }
        set {
            UserDefaults.standard.set(newValue, forKey: key)
        }
    }
    
    func add(username: String) {
        var current = favorites
        if !current.contains(username) {
            current.append(username)
            favorites = current
        }
    }
    
    func remove(username: String) {
        var current = favorites
        current.removeAll { $0 == username }
        favorites = current
    }
    
    func toggle(username: String) {
        if favorites.contains(username) {
            remove(username: username)
        } else {
            add(username: username)
        }
    }
    
    func isFavorite(username: String) -> Bool {
        favorites.contains(username)
    }
}
