//
//  NewsfeedModels.swift
//  VKClient
//
//  Created by Alexey Sergeev on 10/21/20.
//  Copyright (c) 2020 ___ORGANIZATIONNAME___. All rights reserved.
//

import UIKit

enum Newsfeed {
  enum Model {
    
    struct Request {
      enum RequestType {
        case newsfeed
      }
    }
    
    struct Response {
      enum ResponseType {
        case presentNewsfeed(feed: Feed)
      }
    }
    struct ViewModel {
      enum ViewModelData {
        case displayNewsfeed(feedViewModel: FeedViewModel)
      }
    }
  }
}

struct FeedViewModel {
    
    let posts: [Cell]
    
    struct Cell: FeedCellProtocol {
        
        var iconURLString: String
        var generalName: String
        var date: String
        var postDescription: String?
        var likes: String?
        var comments: String?
        var shares: String?
        var views: String?
        var photoAttachment: FeedCellAttachmentsProtocol?
        var sizes: FeedCellSizesProtocol

    }
    
    struct FeedCellAttachment: FeedCellAttachmentsProtocol {
        
        var photoUrlString: String?
        var width: Int
        var height: Int
    }
}
