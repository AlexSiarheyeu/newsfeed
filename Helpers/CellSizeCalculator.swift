//
//  CellSizeCalculator.swift
//  VKClient
//
//  Created by Alexey Sergeev on 10/22/20.
//

import UIKit

struct Sizes: FeedCellSizesProtocol {
    var postLabelFrame: CGRect
    var attachmentFrame: CGRect
    var bottomViewFrame: CGRect
    var totalHeight: CGFloat
}




protocol CellSizeCalculatorProtocol {
    func sizes(postText: String?, photoAttachment: FeedViewModel.FeedCellAttachment?) -> FeedCellSizesProtocol
}

class CellSizeCalculator: CellSizeCalculatorProtocol {
    
    private let screenWidth: CGFloat
    
    init(screenWidth: CGFloat) {
        self.screenWidth = screenWidth
         
    }

    func sizes(postText: String?, photoAttachment: FeedViewModel.FeedCellAttachment?) -> FeedCellSizesProtocol {
        
        var postLabelFrame = CGRect(origin: CGPoint(x: 8, y: 52), size: .zero)
        let width = UIScreen.main.bounds.width

        if let text = postText, !text.isEmpty {
            let height = text.height(width: width, font: UIFont.systemFont(ofSize: 14))
            postLabelFrame.size = CGSize(width: width, height: height)
        }
        
        let top = postLabelFrame.size == CGSize.zero ? 52 :  postLabelFrame.maxY + 8
        var attachFrame = CGRect(origin: CGPoint(x: 0, y: top), size: .zero)
        
        if let attachment = photoAttachment {
            let ratio = CGFloat(Float(attachment.height) / Float(attachment.width))
            attachFrame.size = CGSize(width: width, height: width * ratio)
        }
        
        let bottomViewTop = max(postLabelFrame.maxY, attachFrame.maxY)
        let bottomViewFrame = CGRect(origin: CGPoint(x: 0,
                                                     y: bottomViewTop),
                                     size: CGSize(width: width,
                                                  height: 44))
        
        let totalHeight = bottomViewFrame.maxY
        return Sizes(postLabelFrame: postLabelFrame,
                     attachmentFrame: attachFrame,
                     bottomViewFrame: .zero,
                     totalHeight: totalHeight)
    }
}
