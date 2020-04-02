//
//    SceneDelegate.swift
//     VKFriendsApp
//

import UIKit
import VKSdkFramework

class SceneDelegate: UIResponder, UIWindowSceneDelegate, AuthServiceDelegate, FriendsServiceDelegate {

    var window: UIWindow?
    var authService: AuthService!
    var friendsService: FriendsService!

    func scene(_ scene: UIScene, willConnectTo session: UISceneSession, options connectionOptions: UIScene.ConnectionOptions) {
        // Use this method to optionally configure and attach the UIWindow `window` to the provided UIWindowScene `scene`.
        // If using a storyboard, the `window` property will automatically be initialized and attached to the scene.
        // This delegate does not imply the connecting scene or session are new (see `application:configurationForConnectingSceneSession` instead).
        guard let windowScene = (scene as? UIWindowScene) else { return }
        window = UIWindow(frame: windowScene.coordinateSpace.bounds)
        window?.windowScene = windowScene
        authService = AuthService()
        authService.delegate = self
        
        VKSdk.wakeUpSession(["offline"]) { [weak self] (state, error) in
            guard let self = self else { return }
            switch state {
            case .authorized:
                self.authServiceSignIn()
                self.window?.makeKeyAndVisible()
            default:
                let authVC = UIStoryboard(name: "Auth", bundle: nil).instantiateInitialViewController() as? AuthViewController
                self.window?.rootViewController = authVC
                self.window?.makeKeyAndVisible()
            }
        }
        friendsService = FriendsService()
        friendsService.delegate = self
    }
    
    func scene(_ scene: UIScene, openURLContexts URLContexts: Set<UIOpenURLContext>) {
        if let url = URLContexts.first?.url {
            VKSdk.processOpen(url, fromApplication: UIApplication.OpenURLOptionsKey.sourceApplication.rawValue)
        }
    }

    func sceneDidDisconnect(_ scene: UIScene) {
        // Called as the scene is being released by the system.
        // This occurs shortly after the scene enters the background, or when its session is discarded.
        // Release any resources associated with this scene that can be re-created the next time the scene connects.
        // The scene may re-connect later, as its session was not neccessarily discarded (see `application:didDiscardSceneSessions` instead).
    }

    func sceneDidBecomeActive(_ scene: UIScene) {
        // Called when the scene has moved from an inactive state to an active state.
        // Use this method to restart any tasks that were paused (or not yet started) when the scene was inactive.
    }

    func sceneWillResignActive(_ scene: UIScene) {
        // Called when the scene will move from an active state to an inactive state.
        // This may occur due to temporary interruptions (ex. an incoming phone call).
    }

    func sceneWillEnterForeground(_ scene: UIScene) {
        // Called as the scene transitions from the background to the foreground.
        // Use this method to undo the changes made on entering the background.
    }

    func sceneDidEnterBackground(_ scene: UIScene) {
        // Called as the scene transitions from the foreground to the background.
        // Use this method to save data, release shared resources, and store enough scene-specific state information
        // to restore the scene back to its current state.
    }
    
    //  MARK:   -   FriendsViewControllerDelegate
    
    func vkLogout() {
        VKSdk.forceLogout()
        let authVC = UIStoryboard(name: "Auth", bundle: nil).instantiateInitialViewController() as? AuthViewController
        window?.rootViewController = authVC
    }

    //  MARK:   -   AuthServiceDelegate
    
    func authServiceShouldShow(viewController: UIViewController) {
        window?.rootViewController?.present(viewController, animated: true, completion: nil)
    }
    
    func authServiceSignIn() {        
        let friendsVC = UIStoryboard(name: "Friends", bundle: nil).instantiateInitialViewController() as! FriendsViewController
        window?.rootViewController = friendsVC
    }
    
    func authServiceSignInDidFail() {
    }

    
    //  MARK:   -   Singleton pattern for SceneDelegate
    
    static func shared() -> SceneDelegate {
        
        let scene = UIApplication.shared.connectedScenes.first
        let sceneDelegate: SceneDelegate = ((scene?.delegate as? SceneDelegate)!)
        return sceneDelegate
    }
}

