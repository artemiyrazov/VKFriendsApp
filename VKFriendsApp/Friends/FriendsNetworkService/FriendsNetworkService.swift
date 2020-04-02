//
//	FriendsNetworkService.swift
// 	VKFriendsApp
//

import Foundation

struct FriendsNetworkService {
    
    let networking: Networking
    
    init(networking: Networking) {
        self.networking = networking
    }
    
    func getFriends(response: @escaping (FriendsResponse?)->()) {
        
        let parameters = ["order" : "random",
                          "count" : "5",
                          "fields" : "photo_100"]
        let path = "/method/friends.get"
        
        networking.request(path: path, parameters: parameters) { (data, error) in
            if let error = error {
                print("Error recieved requesting data: \(error.localizedDescription)")
            }
            
            let decoded = self.decodeJSON(type: FriendsResponseWrapped.self, data: data)
            response(decoded?.response)
        }
    }
    
    private func decodeJSON<T: Decodable>(type: T.Type, data: Data?) -> T? {
        let decoder = JSONDecoder()
        decoder.keyDecodingStrategy = .convertFromSnakeCase
        guard let data = data, let response = try? decoder.decode(type.self, from: data) else { return nil }
        return response
    }
}
