//
//	AccountResponse.swift
// 	VKFriendsApp
//

import Foundation

struct AccountResponseWrapped: Decodable {
    let response: AccountResponse
}

struct AccountResponse: Decodable {
    let firstName: String
    let lastName: String
}
