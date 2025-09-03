//
//  Repository.swift
//  GithubClient
//
//  Created by Денис Ефименков on 03.09.2025.
//

import Foundation

struct Repository: Decodable {
    let name: String
    let description: String?
    let htmlUrl: String

    enum CodingKeys: String, CodingKey {
        case name
        case description
        case htmlUrl = "html_url"
    }
}
