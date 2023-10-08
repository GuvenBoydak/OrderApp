//
//  Response.swift
//  OrderApp
//
//  Created by Güven Boydak on 1.10.2023.
//

import Foundation

struct Response : Codable {
    var success : Int?
    var message : String?
}

struct FoodInBasketResponse : Codable {
    var sepet_yemekler : [FoodInBasket]?
    var success : Int?
}

struct FoodResponse : Codable {
    var yemekler : [Food]?
    var success : Int?
}
