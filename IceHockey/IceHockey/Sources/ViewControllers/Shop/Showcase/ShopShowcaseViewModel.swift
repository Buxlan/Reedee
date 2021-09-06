//
//  ShopViewModel.swift
//  IceHockey
//
//  Created by  Buxlan on 9/5/21.
//

import Foundation

struct ShopShowcaseViewModel {
    var sections: [GoodsCategory] = GoodsCategory.categories
    
    func item(at index: IndexPath) -> ShopItem {
        return sections[index.section].items[index.row]
    }    
}
