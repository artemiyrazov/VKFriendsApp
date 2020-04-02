//
//	NetworkService.swift
// 	VKFriendsApp
//

import Foundation

protocol Networking {
    func request(path: String, parameters: [String: String]?, completion: @escaping (Data?, Error?) -> Void)
}

final class NetworkService: Networking {
    
    private let authService: AuthService
    
    init() {
        self.authService = SceneDelegate.shared().authService
    }

    func request(path: String, parameters: [String : String]?, completion: @escaping(Data?, Error?) -> Void) {
        
        guard let token = authService.token else { return }
        var allParameters = [String: String]()
        if let parameters = parameters {
            allParameters = parameters
        }
        allParameters["access_token"] = token
        allParameters["v"] = API.version
        
        let url = self.makeUrl(path: path, parameters: allParameters)
        let request = URLRequest(url: url)
        let task = createDataTask (request: request, completion: completion)
        task.resume()
    }
    
    private func createDataTask(request: URLRequest, completion: @escaping (Data?, Error?) -> Void) -> URLSessionDataTask {
        
        return URLSession.shared.dataTask(with: request, completionHandler: { (data, response, error) in
            DispatchQueue.main.async {
                completion(data, error)
            }
        })
    }

    private func makeUrl(path: String, parameters: [String: String]) -> URL {
        
        var components = URLComponents()

        components.scheme = API.scheme
        components.host = API.host
        components.path = path
        components.queryItems = parameters.map { URLQueryItem(name: $0, value: $1) }
        
        let url = components.url!
        return url
    }
    
}


