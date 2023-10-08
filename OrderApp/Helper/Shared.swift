//
//  Shared.swift
//  OrderApp
//
//  Created by Güven Boydak on 1.10.2023.
//

import Foundation
import FirebaseFirestore

struct Shared {
   static let firebasePath = Firestore.firestore().collection("food")
    static let sepeteEklenen = "Sepete Eklenen"
    static let sepetenSilinen = "Sepeten Silinen"
    static let favoriler = "Favoriler"
}
