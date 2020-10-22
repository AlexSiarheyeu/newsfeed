//
//  NetworkService.swift
//  VKClient
//
//  Created by Alexey Sergeev on 10/21/20.
//

import Foundation
import Alamofire

protocol NetworkingProtocol {
    func request(path: String, parameters: [String: String]?, completion: @escaping (Data?, Error?) -> ())
}

class NetworkService: NetworkingProtocol {
    
    private let authService: AuthService
    
    typealias parameters = [String: String]
    
    init(authService: AuthService = AppDelegate.shared().authService) {
        self.authService = authService
    }
    
    func request(path: String, parameters: [String: String]?, completion: @escaping (Data?, Error?) -> ()) {
        
        guard let token = authService.uniqueToken else { return }
        
        var allParameters = parameters
        allParameters?["access_token"] = token
        allParameters?["v"] = APIConfigure.version
        let url = getURL(path: path, with: allParameters ?? ["":""])
        let request = URLRequest(url: url)
        let task = createDataTask(from: request, completion: completion)
        task.resume()
    }
    private func createDataTask(from request: URLRequest, completion: @escaping (Data?, Error?) -> ()) -> URLSessionDataTask {
        
        return URLSession.shared.dataTask(with: request) { data, response, error in
            DispatchQueue.main.async {
                completion(data, error)
            }
        }
    }
    
    private func getURL(path: String, with parameters: parameters) -> URL {
        
        var components = URLComponents()
        components.scheme = APIConfigure.scheme
        components.host = APIConfigure.host
        components.path = APIConfigure.feed
        components.queryItems = parameters.map({ URLQueryItem(name: $0, value: $1)})
        return components.url!

    }
}
