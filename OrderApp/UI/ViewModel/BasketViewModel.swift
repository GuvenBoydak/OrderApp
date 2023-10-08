//
//  BasketViewModel.swift
//  OrderApp
//
//  Created by Güven Boydak on 4.10.2023.
//

import Foundation
import RxSwift

final class BasketViewModel {
    
    var baskets = BehaviorSubject<[FoodInBasket]>(value: [FoodInBasket]())
    
    func getBasketFood() {
        let params : [String: Any] = ["kullanici_adi":"Guven"]
        NetworkService.shared.request(type: FoodInBasketResponse.self, url: "sepettekiYemekleriGetir.php", method: .post, params: params) { response, error in
            if error != nil {
                print(error?.localizedDescription ?? "")
                self.baskets.onNext([])
            }
            if let data = response, let foods = data.sepet_yemekler{
                self.baskets.onNext(foods)
            }
        }
    }
    
    func deleteFoodToBasket(id:Int) {
        let params : [String:Any] = ["sepet_yemek_id":id,"kullanici_adi":"Guven"]
        NetworkService.shared.request(type: Response.self, url: "sepettenYemekSil.php", method: .post, params: params) { response, error in
            if error != nil {
                print(error?.localizedDescription ?? "")
            }
            if let data = response {
                print("Message : \(data.message)         Succeses : \(data.success)")
            }
        }
       getBasketFood()
    }
    
    func addFirebasedeletedItem(foodInBaseket: FoodInBasket) {
        guard let name = foodInBaseket.yemek_adi,let price = foodInBaseket.yemek_fiyat,let quantity = foodInBaseket.yemek_siparis_adet,let image = foodInBaseket.yemek_resim_adi else {return}
        let firebaseFood : [String:Any] = ["id":"","name":name,"image":image,"price":price,"quantity":quantity,"status":Shared.sepetenSilinen]
        Shared.firebasePath.document().setData(firebaseFood)
    }
}
