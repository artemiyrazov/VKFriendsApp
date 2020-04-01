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
        authService.wakeUpSession()
    }
    
}

