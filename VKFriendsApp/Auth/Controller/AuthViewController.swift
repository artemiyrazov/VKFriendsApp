//
//	ViewController.swift
// 	VKFriendsApp
//

import UIKit

class AuthViewController: UIViewController {
    
    private var authService: AuthService!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        authService = SceneDelegate.shared().authService
    }

    @IBAction func signInButtonPressed(_ sender: Any) {
        
        if InternetConnectionManager.isConnectedToNetwork() {
            authService.wakeUpSession()
        } else {
            let alert = UIAlertController(title: "No internet connection",
                                          message: "Please, connect to the network to continue",
                                          preferredStyle: .alert)
            
            alert.addAction(UIAlertAction(title: "OK",
                                          style: .default))
            self.present(alert, animated: true, completion: nil)
        }
        
    }
    
}

