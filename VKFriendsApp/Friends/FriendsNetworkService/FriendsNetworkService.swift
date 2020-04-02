//
//	FriendsNetworkService.swift
// 	VKFriendsApp
//

import Foundation

class FriendsNetworkService {
        
    static func getFriends(response: @escaping (FriendsResponse?)->()) {
        
        let parameters = ["order" : "random",
                          "count" : "5",
                          "fields" : "photo_100"]
        let path = "/method/friends.get"
        
        NetworkService().request(path: path, parameters: parameters) { (data, error) in
            if let error = error {
                print("Error recieved requesting data: \(error.localizedDescription)")
            }
            
            let decoded = self.decodeJSON(type: FriendsResponseWrapped.self, data: data)
            response(decoded?.response)
        }
    }
    
    static func getAccount (response: @escaping (AccountResponse?)->()) {
        
        let path = "/method/account.getProfileInfo"
        
        NetworkService().request(path: path, parameters: nil) { (data, error) in
            if let error = error {
                print("Error recieved requesting data: \(error.localizedDescription)")
            }
            
            let decoded = self.decodeJSON(type: AccountResponseWrapped.self, data: data)
            response(decoded?.response)
        }
    }
    
    static func getPhoto (url: String, response: @escaping (Data)->()) {
        let url = URL(string: url)

        DispatchQueue.global().async {
            guard let data = try? Data(contentsOf: url!) else { return }
            response(data)
        }
    }
    
    
    
    static private func decodeJSON<T: Decodable>(type: T.Type, data: Data?) -> T? {
        let decoder = JSONDecoder()
        decoder.keyDecodingStrategy = .convertFromSnakeCase
        guard let data = data, let response = try? decoder.decode(type.self, from: data) else { return nil }
        return response
    }
}
