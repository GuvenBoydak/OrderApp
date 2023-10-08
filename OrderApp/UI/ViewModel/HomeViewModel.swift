//
//  HomeViewModel.swift
//  OrderApp
//
//  Created by Güven Boydak on 1.10.2023.
//

import Foundation
import RxSwift
import FirebaseFirestore

final class HomeViewModel {
    var foods = BehaviorSubject<[Food]>(value: [Food]())
    
    func getFoods() {
        NetworkService.shared.request(type: FoodResponse.self,url: "tumYemekleriGetir.php", method: .get, params: nil) { response,error in
            if error != nil {
                print(error!.localizedDescription)
            }
            guard let  data = response else {return}
            if let foodList = data.yemekler {
                self.foods.onNext(foodList)
            }
        }
    }
    
    func searchFoods(keyword: String) {
        var list = [Food]()
        NetworkService.shared.request(type: FoodResponse.self,url: "tumYemekleriGetir.php", method: .get, params: nil) { response,error in
            if error != nil {
                print(error!.localizedDescription)
            }
            guard let  data = response else {return}
            if let foodList = data.yemekler {
                list =  foodList.filter { food in
                     food.yemek_adi!.lowercased().contains(keyword.lowercased())
                }
                self.foods.onNext(list)
            }
        }
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
        var firebaseFood : [String:Any] = ["id":"","name":name,"image":image,"price":price,"quantity":quantity,"status":Shared.sepeteEklenen]
        Shared.firebasePath.document().setData(firebaseFood)
    }
}
