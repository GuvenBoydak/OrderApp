//
//  DetailBasket.swift
//  OrderApp
//
//  Created by Güven Boydak on 8.10.2023.
//

import Foundation

struct DetailBasket {
    var id: String?
    var image: String?
    var name: String?
    var price: String?
    var quantity: String?
    var status: String?
    
    init() {
    }
    
    init(id: String, image: String, name: String, price: String, quantity: String, status: String) {
        self.id = id
        self.image = image
        self.name = name
        self.price = price
        self.quantity = quantity
     self.status = status
    }
}
