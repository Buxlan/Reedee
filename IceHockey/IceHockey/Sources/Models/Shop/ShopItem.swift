//
//  ShopItem.swift
//  IceHockey
//
//  Created by  Buxlan on 9/5/21.
//

import Foundation
import UIKit

enum ColorComponent: Codable {
    case red(value: CGFloat)
    case green(value: CGFloat)
    case blue(value: CGFloat)
    case alpha(value: CGFloat)
}

extension ColorComponent {
    
    private enum CodingKeys: String, CodingKey {
        case red
        case green
        case blue
        case alpha
    }
    
    enum ColorComponentCodingError: Error {
        case decoding(String)
    }
    
    init(from decoder: Decoder) throws {
        let values = try decoder.container(keyedBy: CodingKeys.self)
        if let value = try? values.decode(CGFloat.self, forKey: .red) {
            self = .red(value: value)
            return
        } else if let value = try? values.decode(CGFloat.self, forKey: .green) {
            self = .green(value: value)
            return
        } else if let value = try? values.decode(CGFloat.self, forKey: .blue) {
            self = .blue(value: value)
            return
        } else if let value = try? values.decode(CGFloat.self, forKey: .alpha) {
            self = .alpha(value: value)
            return
        }
        throw ColorComponentCodingError.decoding("Error decoding category: \(dump(values))")
    }
    
    func encode(to encoder: Encoder) throws {
        var container = encoder.container(keyedBy: CodingKeys.self)
        switch self {
        case .red(let value):
            try container.encode(value, forKey: .red)
        case .green(let value):
            try container.encode(value, forKey: .green)
        case .blue(let value):
            try container.encode(value, forKey: .blue)
        case .alpha(let value):
            try container.encode(value, forKey: .alpha)
        }
    }
}

struct CodableColor: Codable {
    var red: CGFloat
    var green: CGFloat
    var blue: CGFloat
    var alpha: CGFloat
}

extension CodableColor {
    var color: UIColor {
        UIColor(red: red, green: green, blue: blue, alpha: alpha)
    }
}

struct GoodsCategory: Codable {
    var category: ShopCategoryItem
    var items: [ShopItem]
    
    static var categories: [GoodsCategory] = [
        GoodsCategory(category: .init(category: "Одежда"),
                      items: [
                        ShopItem(),
                        ShopItem(),
                        ShopItem(),
                        ShopItem(),
                        ShopItem(),
                        ShopItem()
                      ])
    ]
}

protocol ShopItemProtocol: Codable {
    var name: String { get set }
    var description: String { get set }
    var imageURL: URL? { get set }
    var price: CGFloat { get set }
    var size: CGFloat? { get set }
    var category: ShopCategoryItem { get set }
    var codableColor: CodableColor { get set }
    var sizeable: Bool { get set }
}

struct ShopItem: ShopItemProtocol {
    var name: String
    var description: String
    var imageURL: URL?
    var price: CGFloat
    var size: CGFloat?
    var codableColor: CodableColor
    var category: ShopCategoryItem
    var sizeable: Bool
    var colorable: Bool
    
    init(name: String = "Item 0",
         description: String = "To save an array of Codable Person objects, do exactly the same thing. Array con‐ forms to Codable, so use PropertyListEncoder to encode the array into a Data object and call write(to:options:)",
         imageURL: URL? = nil,
         price: CGFloat = 0.0,
         size: CGFloat? = 0.0,
         category: ShopCategoryItem = .init(category: "Category 0"),
         codableColor: CodableColor = .init(red: 0, green: 0, blue: 0, alpha: 1),
         sizeable: Bool = false,
         colorable: Bool = false) {
        self.name = name
        self.description = description
        self.price = price
        self.size = size
        self.category = category
        self.codableColor = codableColor
        self.sizeable = sizeable
        self.colorable = colorable
    }
}

extension ShopItemProtocol {
    var color: UIColor {
        .init(red: codableColor.red,
              green: codableColor.green,
              blue: codableColor.blue,
              alpha: codableColor.alpha)
    }
}
