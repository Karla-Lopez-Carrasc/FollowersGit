//
//  Follower.swift
//  Followers
//
//  Created by Karla Lopez on 10/01/26.
//

import Foundation

struct Follower: Hashable {
    let login: String
    let avatarUrl: String
}

extension FollowerDTO {
    func toDomain() -> Follower {
        Follower(login: login, avatarUrl: avatarUrl)
    }
}
