//
//  Response.swift
//  OrderApp
//
//  Created by Güven Boydak on 1.10.2023.
//

import Foundation

class Response : Codable {
    var success : Int?
    var message : String?
}

class FoodInBasketResponse : Codable {
    var sepet_yemekler : [FoodInBasket]?
    var success : Int?
}

class FoodResponse : Codable {
    var yemekler : [Food]?
    var success : Int?
}
