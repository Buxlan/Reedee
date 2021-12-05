//
//  Fonts.swift
//  Places
//
//  Created by  Buxlan on 6/6/21.
//

import UIKit

enum Fonts {
    
    enum Regular {
        static let caption = FontFamily.Roboto.regular.font(size: 12)
        static let body = FontFamily.Roboto.regular.font(size: 14)
        static let subhead = FontFamily.Roboto.regular.font(size: 16)
        static let title = FontFamily.Roboto.regular.font(size: 20)
        static let scoreDisplay = FontFamily.Roboto.regular.font(size: 50)
    }
    
    enum Medium {
        static let body = FontFamily.Roboto.medium.font(size: 14)
        static let subhead = FontFamily.Roboto.medium.font(size: 16)
        static let title = FontFamily.Roboto.medium.font(size: 20)
    }
    
    enum Bold {
        static let body = FontFamily.Roboto.bold.font(size: 14)
        static let subhead = FontFamily.Roboto.bold.font(size: 16)
    }
    
}
