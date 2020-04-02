//
//	FriendsService.swift
// 	VKFriendsApp
//

import Foundation

protocol FriendsServiceDelegate: class {
    func vkLogout()
}

class FriendsService {
    weak var delegate: FriendsServiceDelegate?

}
