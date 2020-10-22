//
//  String + Extensions.swift
//  VKClient
//
//  Created by Alexey Sergeev on 10/22/20.
//

import UIKit

extension String {
    
    func height(width: CGFloat, font: UIFont)->CGFloat{
        
        let textSize = CGSize(width: width, height: .greatestFiniteMagnitude)
        let size = self.boundingRect(with: textSize, options: .usesLineFragmentOrigin, attributes: [NSAttributedString.Key.font: font], context: nil)
        return ceil(size.height)
    }
}
