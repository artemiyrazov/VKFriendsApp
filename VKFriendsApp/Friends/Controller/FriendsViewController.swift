//
//	FriendsViewController.swift
// 	VKFriendsApp
//

import UIKit

class FriendsViewController: UIViewController {
        
    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var userFirstNameLabel: UILabel!
    @IBOutlet weak var userLastNameLabel: UILabel!
    var friends = [FriendItem]()
    
    override func viewDidLoad() {
        super.viewDidLoad()

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
        friends.removeAll()
        tableView.reloadData()
        loadFriends()
    }
    
}



extension FriendsViewController: UITableViewDelegate {}

extension FriendsViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return friends.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath) as! FriendCell
        let friend = friends[indexPath.row]
        cell.configure(friend: friend)
        return cell
    }
    
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 90
    }
    
}

