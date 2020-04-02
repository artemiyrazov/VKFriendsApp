//
//	FriendsViewController.swift
// 	VKFriendsApp
//

import UIKit
import VKSdkFramework

class FriendsViewController: UIViewController {
        
    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var userFirstNameLabel: UILabel!
    @IBOutlet weak var userLastNameLabel: UILabel!
    var friends = [FriendItem]()
    private var friendsService: FriendsService!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        friendsService = SceneDelegate.shared().friendsService

        FriendsNetworkService.getAccount { [weak self] accountResponse in
            guard   let self = self,
                    let accountResponse = accountResponse else { return }
            self.userFirstNameLabel.text = accountResponse.firstName
            self.userLastNameLabel.text = accountResponse.lastName
            
        }
        loadFriends()
    }
    
    func loadFriends () {
        FriendsNetworkService.getFriends { [weak self] friendsResponse in
            guard   let self = self,
                    let friendsResponse = friendsResponse else { return }
            
            self.friends = friendsResponse.items
            self.tableView.reloadData()
        }
    }
    
    @IBAction func reloadButtonPressed(_ sender: Any) {
        if InternetConnectionManager.isConnectedToNetwork() {
            friends.removeAll()
            tableView.reloadData()
            loadFriends()
        } else {
            let alert = UIAlertController(title: "No internet connection",
                                          message: "Please, connect to the network to continue",
                                          preferredStyle: .alert)
            
            alert.addAction(UIAlertAction(title: "OK",
                                          style: .default))
            self.present(alert, animated: true, completion: nil)
        }
    }
    
    @IBAction func logoutButtonPressed(_ sender: Any) {
        
        let actionSheet = UIAlertController(title: "Are you sure?",
                                            message: "You will need to log in again",
                                            preferredStyle: .actionSheet)
        
        actionSheet.addAction(UIAlertAction(title: "Cancel",
                                            style: .cancel))
        
        actionSheet.addAction(UIAlertAction(title: "Yes",
                                            style: .destructive,
                                            handler: { [weak self] (UIAlertAction) in
            guard let self = self else { return }
            self.friendsService.delegate?.vkLogout()
        }))
        self.present(actionSheet, animated: true, completion: nil)
    }
}

