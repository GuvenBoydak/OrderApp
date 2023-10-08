//
//  Food.swift
//  OrderApp
//
//  Created by Güven Boydak on 1.10.2023.
//

import Foundation

struct Food : Codable {
    
    var yemek_id : String?
    var yemek_adi : String?
    var yemek_resim_adi : String?
    var yemek_fiyat : String?
    var isFavorite : Bool? = false
    var quantity : Int?
    
    init() {
    }
    
    init(yemek_id: String, yemek_adi: String, yemek_resim_adi: String, yemek_fiyat: String) {
        self.yemek_id = yemek_id
        self.yemek_adi = yemek_adi
        self.yemek_resim_adi = yemek_resim_adi
        self.yemek_fiyat = yemek_fiyat
    }
    
    mutating func setIsFavorite(value :Bool) {
        self.isFavorite = value
    }
    
    mutating func setQuantity(value: Int) {
        self.quantity = value
    }
}

