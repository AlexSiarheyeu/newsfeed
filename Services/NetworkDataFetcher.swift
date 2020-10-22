//
//  NetworkDataFetcher.swift
//  VKClient
//
//  Created by Alexey Sergeev on 10/21/20.
//

import Foundation

protocol NetworkDataFetcherProtocol {
    func getNewsFeed(response: @escaping (Feed?) -> ())
}

class NetworkDataFetcher: NetworkDataFetcherProtocol {
    
    let networkService: NetworkingProtocol
    
    init(networkService: NetworkingProtocol) {
        self.networkService = networkService
    }
    
    func getNewsFeed(response: @escaping (Feed?) -> ()) {
        
        let parameters = ["filters": "post, photo"]
        
        networkService.request(path: APIConfigure.feed, parameters: parameters) { (data, error) in
            
            if let error = error {
                print(error.localizedDescription)
                response(nil)
            }
            
            let decodedNewsFeedResponse = self.decodeJSON(type: FeedResponseWrapped.self, from: data)
            response(decodedNewsFeedResponse?.response)
            
        }
    }
    
    private func decodeJSON<T: Decodable> (type: T.Type, from data: Data?) -> T? {
        
        let decoder = JSONDecoder()
        decoder.keyDecodingStrategy = .convertFromSnakeCase
        guard let data = data else { return nil }
        let response = try? decoder.decode(type.self, from: data)
        return response
        
    }
}
