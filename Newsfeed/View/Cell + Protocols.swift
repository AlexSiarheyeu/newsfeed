//
//  Cell + Protocols.swift
//  VKClient
//
//  Created by Alexey Sergeev on 10/22/20.
//

import UIKit

protocol FeedCellProtocol {
    var iconURLString: String { get }
    var generalName: String { get }
    var date: String { get }
    var postDescription: String? { get }
    var likes: String? { get }
    var comments: String? { get }
    var shares: String? { get }
    var views: String? { get }
    var photoAttachment: FeedCellAttachmentsProtocol? { get }
    var sizes: FeedCellSizesProtocol { get }
}

protocol FeedCellSizesProtocol {
    var postLabelFrame: CGRect {get}
    var attachmentFrame: CGRect {get}
    var bottomViewFrame: CGRect {get}
    var totalHeight: CGFloat {get}
}

protocol FeedCellAttachmentsProtocol {
    var photoUrlString: String? { get }
    var width: Int { get }
    var height: Int { get }
}
