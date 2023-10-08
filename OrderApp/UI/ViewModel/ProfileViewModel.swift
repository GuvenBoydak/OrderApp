//
//  ProfileViewModel.swift
//  OrderApp
//
//  Created by Güven Boydak on 8.10.2023.
//

import Foundation
import RxSwift


final class ProfileViewModel {
    var details = BehaviorSubject<[DetailBasket]>(value: [DetailBasket]())
    
    func searchDetailBasket(keyword:String) {
        var detailList = [DetailBasket]()
        Shared.firebasePath.addSnapshotListener { snapshot, error in
            if error != nil {
                print(error?.localizedDescription)
            }
            if let documents = snapshot {
                do {
                    detailList = try self.details.value()
                    detailList.removeAll()
                } catch  {
                    print(error)
                }
                for document in documents.documents {
                    let data = document.data()
                    let id = document.documentID
                    if let image = data["image"] as? String,
                       let name = data["name"] as? String,
                       let price = data["price"] as? String,
                       let quantity = data["quantity"] as? String,
                       let status = data["status"] as? String {
                        
                        let detail = DetailBasket(id: id, image: image, name: name, price: price, quantity: quantity, status: status)
                        if detail.status == keyword {
                            detailList.append(detail)
                        }
                    }
                }
                self.details.onNext(detailList)
            }
        }
    }
}
