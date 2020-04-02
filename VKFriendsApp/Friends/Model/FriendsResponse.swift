//
//	FriendsResponse.swift
// 	VKFriendsApp
//

import Foundation

struct FriendsResponseWrapped: Decodable {
    let response: FriendsResponse
}

struct FriendsResponse: Decodable {
    let count: Int
    let items: [FriendItem]
}

struct FriendItem: Decodable {
    let id: Int
    let firstName: String
    let lastName: String
    let photo100: String
}
