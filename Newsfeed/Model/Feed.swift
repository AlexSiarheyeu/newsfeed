//
//  Feed.swift
//  VKClient
//
//  Created by Alexey Sergeev on 10/21/20.
//

import Foundation

struct Feed: Decodable {
    var items: [FeedItem]
    var profiles: [Profile]
    var groups: [Group]
}

struct FeedItem: Decodable {
    let sourceId: Int
    let postId: Int
    let date: Double
    let text: String?
    let comments: CountableItem?
    let likes: CountableItem?
    let reposts: CountableItem?
    let views: CountableItem?
    let attachments: [Attachment]?
}

struct Attachment: Decodable {
    let photo: Photo?
}

struct Photo: Decodable {
    let sizes: [PhotoSize]
    
    var height: Int {
        return size().height
    }
    
    var width: Int {
        return size().width
    }
    
    var url: String {
        return size().url
    }
    
    private func size() -> PhotoSize {
        if let sizeX = sizes.first(where: {photo in photo.type == "x"}) {
            return sizeX
        } else if let anotherSize  = sizes.last {
            return anotherSize
        } else {
            return PhotoSize(type: "failure", url: "failure", width: 0, height: 0)
        }
    }
}

struct PhotoSize: Decodable {
    let type: String
    let url: String
    let width: Int
    let height: Int
}

protocol ProfileRepresentable {
    var id: Int {get}
    var name: String {get}
    var photo: String {get}
}

struct Profile: Decodable, ProfileRepresentable {
    
    let id: Int
    let firstName: String
    let lastName: String
    let photo100: String
    
    var name: String {return firstName + " " + lastName}
    var photo: String { return photo100 }
    
}

struct Group: Decodable, ProfileRepresentable {
    
    let id: Int
    let name: String
    let photo100: String
    
    var photo: String { return photo100 }
    
}

struct CountableItem: Decodable {
    let count: Int
}

struct FeedResponseWrapped: Decodable {
    let response: Feed
}
