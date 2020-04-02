//
//	FriendsViewController.swift
// 	VKFriendsApp
//

import UIKit

class FriendsViewController: UIViewController {
        
    var friendsNS: FriendsNetworkService = FriendsNetworkService(networking: NetworkService())
    
    override func viewDidLoad() {
        super.viewDidLoad()

        friendsNS.getFriends { response in
            guard let response = response else { return }
            print(response.items)
        }
    }
}
