//
//  DTO.swift
//  Followers
//
//  Created by Karla Lopez on 10/01/26.
//

import Foundation

struct FollowerDTO: Codable {
    let login: String
    let avatarUrl: String

    enum CodingKeys: String, CodingKey {
        case login
        case avatarUrl = "avatar_url"
    }
}

