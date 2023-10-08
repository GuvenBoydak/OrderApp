//
//  DetailViewModel.swift
//  OrderApp
//
//  Created by Güven Boydak on 6.10.2023.
//

import Foundation

final class DetailViewModel {
    
    func addToFavorite(id:String,name:String,price:String,imageName:String) {
        let firebaseFood : [String:Any] = ["id":"","name":name,"image":imageName,"price":price,"quantity":"","status":"Favorilere Eklendi"]
        Shared.firebasePath.document().setData(firebaseFood)
    }
    
    func addFoodToBasket(food: FoodInBasket) {
        guard let name = food.yemek_adi,let price = food.yemek_fiyat,let image = food.yemek_resim_adi,let quantity = food.yemek_siparis_adet else {return}
        let params : [String:Any] = ["yemek_adi":name,"yemek_resim_adi":image,"yemek_fiyat":Int(price),"yemek_siparis_adet":Int(quantity),"kullanici_adi":"Guven"]
        NetworkService.shared.request(type: Response.self, url: "sepeteYemekEkle.php", method: .post,params: params) { response, error in
            if error != nil {
                print(error?.localizedDescription ?? "")
            }
            if let message = response {
                print("message : \(message.success) ,success : \(message.success)")
            }
        }
        let firebaseFood : [String:Any] = ["id":"","name":name,"image":image,"price":price,"quantity":quantity,"status":"Sepete Eklendi"]
        Shared.firebasePath.document().setData(firebaseFood)
    }
}
