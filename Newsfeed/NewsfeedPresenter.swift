//
//  NewsfeedPresenter.swift
//  VKClient
//
//  Created by Alexey Sergeev on 10/21/20.
//  Copyright (c) 2020 ___ORGANIZATIONNAME___. All rights reserved.
//

import UIKit

protocol NewsfeedPresentDataProtocol {
  func presentData(response: Newsfeed.Model.Response.ResponseType)
}

class NewsfeedPresenter: NewsfeedPresentDataProtocol {
    
    weak var viewController: NewsfeedDisplayDataProtocol?
    var cellCalculator: CellSizeCalculatorProtocol = CellSizeCalculator(screenWidth: UIScreen.main.bounds.width)
    
    let dateFormatter: DateFormatter = {
        let formatter = DateFormatter()
        formatter.locale = Locale(identifier: "ru_RU")
        formatter.dateFormat = "d MMMM 'в' HH:m"
        return formatter
    }()
  
    func presentData(response: Newsfeed.Model.Response.ResponseType) {
        
        switch response {
            case .presentNewsfeed(let newsfeed):
                let cells = newsfeed.items.map { (feedItem) in
                    cellViewModel(feedItem: feedItem, profiles: newsfeed.profiles, groups: newsfeed.groups)
                }
                let feedViewModel = FeedViewModel(posts: cells)
                viewController?.displayData(viewModel: .displayNewsfeed(feedViewModel: feedViewModel))
        }
    }
    
    private func cellViewModel(feedItem: FeedItem, profiles: [Profile], groups: [Group]) -> FeedViewModel.Cell {
        
        let profile = self.profile(sourceId: feedItem.sourceId, profiles: profiles, groups: groups)
        
        let date = Date(timeIntervalSince1970: feedItem.date)
        let dateTitle = dateFormatter.string(from: date)
        
        let photo = self.photoAttachment(feedItem: feedItem)
        
        let sizes = cellCalculator.sizes(postText: feedItem.text, photoAttachment: photo)
        print(sizes)
        return FeedViewModel.Cell(iconURLString: profile.photo,
                                  generalName: profile.name,
                                  date: dateTitle,
                                  postDescription: feedItem.text,
                                  likes: String(feedItem.likes?.count ?? 0),
                                  comments: String(feedItem.comments?.count ?? 0),
                                  shares: String(feedItem.reposts?.count ?? 0),
                                  views: String(feedItem.views?.count ?? 0),
                                  photoAttachment: photo,
                                  sizes: sizes)
        
    }
    
    private func profile(sourceId: Int, profiles: [Profile], groups: [Group]) -> ProfileRepresentable  {
        
        let profilesOrGroups: [ProfileRepresentable] = sourceId >= 0 ? profiles : groups
        
        let plusSourceId = sourceId >= 0 ? sourceId : -sourceId
        let profile = profilesOrGroups.first { (profile) in
            profile.id == plusSourceId
        }
        return profile!
    }
    
    private func photoAttachment(feedItem: FeedItem) -> FeedViewModel.FeedCellAttachment? {
        
        guard let photos =  feedItem.attachments?.compactMap({ (attach) in
            attach.photo
        }), let photo = photos.first  else { return nil }
        return FeedViewModel.FeedCellAttachment(photoUrlString: photo.url, width: photo.width, height: photo.height)
    }
}
