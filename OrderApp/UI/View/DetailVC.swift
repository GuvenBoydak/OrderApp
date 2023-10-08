//
//  DetailVC.swift
//  OrderApp
//
//  Created by Güven Boydak on 1.10.2023.
//

import UIKit
import Kingfisher

final class DetailVC: UIViewController {
    @IBOutlet weak var foodImage: UIImageView!
    @IBOutlet weak var foodNameLabel: UILabel!
    @IBOutlet weak var foodPrice: UILabel!
    @IBOutlet weak var totolPriceLabel: UILabel!
    @IBOutlet weak var addToBasketButton: UIButton!
    @IBOutlet weak var foodQuantityLabel: UILabel!
    @IBOutlet weak var totalPriceContainerView: UIView!
    
    var food : Food?
    var DetailVM = DetailViewModel()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        if let foodValue = food, let name = foodValue.yemek_adi,let price = foodValue.yemek_fiyat, let image = foodValue.yemek_resim_adi{
            foodNameLabel.text = name
            foodPrice.text = "\(price) ₺"
            if let url = URL(string: "http://kasimadalan.pe.hu/yemekler/resimler/\(image)") {
                DispatchQueue.main.async {
                    self.foodImage.kf.setImage(with: url)
                }
            }
            totolPriceLabel.text = price
        }
        addToBasketButton.layer.cornerRadius = 12
        totalPriceContainerView.layer.borderWidth = 1
        totalPriceContainerView.layer.borderColor = UIColor.systemOrange.cgColor
        totalPriceContainerView.layer.cornerRadius = 12
    }
    
    
    @IBAction func increaseQuantityDidTapped(_ sender: Any) {
        if let quantity = Int(foodQuantityLabel.text ?? "0"),let price = Int(totolPriceLabel.text ?? "0"),let foodPrice = Int(food?.yemek_fiyat ?? "0") {
            foodQuantityLabel.text = String(quantity + 1)
            let total = price + foodPrice
            totolPriceLabel.text = String(total)
        }
    }
    
    @IBAction func decreaseQuantityDidTapped(_ sender: Any) {
        if let quantity = Int(foodQuantityLabel.text ?? "0"),let price = Int(totolPriceLabel.text ?? "0"),let foodPrice = Int(food?.yemek_fiyat ?? "0"),quantity > 1{
            foodQuantityLabel.text = String(quantity - 1)
            let total = price - foodPrice
            totolPriceLabel.text = String(total)
        }
    }
    
    @IBAction func addToFavoriteDidTapped(_ sender: Any) {
        if let foodValue = food, let id = foodValue.yemek_id, let name = foodValue.yemek_adi,let price = foodValue.yemek_fiyat, let image = foodValue.yemek_resim_adi{
            DetailVM.addToFavorite(id: id, name: name, price: price, imageName: image)
        }
    }
    
    @IBAction func closePageDidTapped(_ sender: Any) {
        dismiss(animated: true)
    }
    
    @IBAction func addToBasketDidTapped(_ sender: Any) {
        if let foodValue = food, let id = foodValue.yemek_id, let name = foodValue.yemek_adi,let price = foodValue.yemek_fiyat, let image = foodValue.yemek_resim_adi,let quantity = foodQuantityLabel.text{
            let basket = FoodInBasket(sepet_yemek_id: id, yemek_adi: name, yemek_resim_adi: image, yemek_fiyat: price, yemek_siparis_adet: quantity, kullanici_adi: "Guven")
            DetailVM.addFoodToBasket(food: basket)
        }
    }
}
