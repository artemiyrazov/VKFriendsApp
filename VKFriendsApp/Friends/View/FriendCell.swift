//
//	FriendCell.swift
// 	VKFriendsApp
//

import UIKit

class FriendCell: UITableViewCell {
    
    
    @IBOutlet weak var photoImage: UIImageView!
    @IBOutlet weak var firstNameLabel: UILabel!
    @IBOutlet weak var lastNameLabel: UILabel!
        
    
    func configure (friend: FriendItem) {
        firstNameLabel.text = friend.firstName
        lastNameLabel.text = friend.lastName
        
        FriendsNetworkService.getPhoto(url: friend.photo100) { [weak self] data in
            guard let self = self else { return }
            DispatchQueue.main.async {
                self.photoImage.image = UIImage(data: data)!
            }
        }
    }
}
