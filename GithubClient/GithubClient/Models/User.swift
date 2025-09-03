//
//  User.swift
//  GithubClient
//
//  Created by Денис Ефименков on 03.09.2025.
//

import Foundation

struct User: Decodable {
    let login: String
    let name: String?
    let bio: String?
    let avatarUrl: String

    enum CodingKeys: String, CodingKey {
        case login
        case name
        case bio
        case avatarUrl = "avatar_url"
    }
}
