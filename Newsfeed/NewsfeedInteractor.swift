//
//  NewsfeedInteractor.swift
//  VKClient
//
//  Created by Alexey Sergeev on 10/21/20.
//  Copyright (c) 2020 ___ORGANIZATIONNAME___. All rights reserved.
//

import UIKit

protocol NewsfeedFetchDataProtocol {
  func makeRequest(request: Newsfeed.Model.Request.RequestType)
}

class NewsfeedInteractor: NewsfeedFetchDataProtocol {

    var presenter: NewsfeedPresentDataProtocol?
    private var fetcher = NetworkDataFetcher(networkService: NetworkService())
  
    func makeRequest(request: Newsfeed.Model.Request.RequestType) {

        switch request {
            case .newsfeed:
                fetcher.getNewsFeed { [weak self] (response) in
                guard let newsfeed = response  else { return }
                self?.presenter?.presentData(response: .presentNewsfeed(feed: newsfeed))
            }
        }
    }
}
