//
//  NetworkService.swift
//  OrderApp
//
//  Created by Güven Boydak on 1.10.2023.
//

import Foundation
import Alamofire

final class NetworkService {
    static var shared = NetworkService()
    
   private init() {
    }
    
    func request<T : Codable>(type: T.Type,url: String,method: HTTPMethod,params: Parameters?,complation: @escaping (T?,Error?)-> ()) {
        if params != nil  {
            AF.request("http://kasimadalan.pe.hu/yemekler/\(url)",method: method,parameters: params).response { response in
                if response.error != nil {
                    print(response.error?.localizedDescription)
                }
                guard let data = response.data else {return}
                do {
                    let datas = try JSONDecoder().decode(T.self, from: data)
                    complation(datas,nil)
                } catch {
                    print(error.localizedDescription)
                    complation(nil,error)
                }
            }
        } else {
            AF.request("http://kasimadalan.pe.hu/yemekler/\(url)",method: method).response { response in
                if response.error != nil {
                    print(response.error?.localizedDescription)
                }
                guard let data = response.data else {return}
                do {
                    let datas = try JSONDecoder().decode(T.self, from: data)
                    complation(datas,nil)
                } catch {
                    print(error.localizedDescription)
                    complation(nil,error)
                }
            }
        }
    }
}
