//
//  homeFoodCell.swift
//  OrderApp
//
//  Created by Güven Boydak on 1.10.2023.
//

import UIKit
import Kingfisher

protocol HomeFoodCellProtocol {
    func addToBasket(indexPath:IndexPath)
}

final class homeFoodCell: UICollectionViewCell {
    @IBOutlet weak var foodContainerView: UIView!
    @IBOutlet weak var foodImage: UIImageView!
    @IBOutlet weak var foodNameLabel: UILabel!
    @IBOutlet weak var foodPriceLabel: UILabel!
    @IBOutlet weak var foodQuantityLabel: UILabel!
    @IBOutlet weak var addToBaseketButton: UIButton!
    
    var delegate : HomeFoodCellProtocol?
    var index : IndexPath?
    
    func setupCell(food:Food) {
        foodNameLabel.text = food.yemek_adi!
        foodPriceLabel.text = "\(food.yemek_fiyat!) ₺"
        
        if let url = URL(string: "http://kasimadalan.pe.hu/yemekler/resimler/\(food.yemek_resim_adi!)") {
            DispatchQueue.main.async {
                self.foodImage.kf.setImage(with: url)
            }
        }
        
        foodContainerView.layer.borderWidth = 1
        foodContainerView.layer.borderColor = UIColor.systemIndigo.cgColor
        foodContainerView.layer.cornerRadius = 10
        foodImage.layer.cornerRadius = 10
        addToBaseketButton.layer.cornerRadius = 8
    }
    
    @IBAction func increaseQuantityDidTapped(_ sender: Any) {
        if let textQuantity = foodQuantityLabel.text, var quantity = Int(textQuantity){
         quantity = quantity + 1
            foodQuantityLabel.text = "\(quantity)"
        }
    }
    
    @IBAction func decreaseQuantityDidTapped(_ sender: Any) {
        if let textQuantity = foodQuantityLabel.text, var quantity = Int(textQuantity), quantity > 0{
         quantity = quantity - 1
            foodQuantityLabel.text = "\(quantity)"
        }
    }
    
    @IBAction func addToBasketDidTapped(_ sender: Any) {
        if let index = index {
            delegate?.addToBasket(indexPath: index)
        }
    }
}
