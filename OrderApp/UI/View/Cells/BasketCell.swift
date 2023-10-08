//
//  BasketCell.swift
//  OrderApp
//
//  Created by Güven Boydak on 1.10.2023.
//

import UIKit
import Kingfisher

protocol RemoveToBasketItemProtocol {
    func removetoBasketItem(index:IndexPath)
}

final class BasketCell: UITableViewCell {

    @IBOutlet weak var basketItemContainerCell: UIView!
    @IBOutlet weak var foodImage: UIImageView!
    @IBOutlet weak var foodQuantityLabel: UILabel!
    @IBOutlet weak var foodPriceLabel: UILabel!
    @IBOutlet weak var foodNameLabel: UILabel!
    @IBOutlet weak var totalPriceLabel: UILabel!
    
    var delegate : RemoveToBasketItemProtocol?
    var indexPath : IndexPath?
    
    override func awakeFromNib() {
        super.awakeFromNib()
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
    }
    
    func setupCell(basket: FoodInBasket) {
        
        foodPriceLabel.text = "Fiyat : \(basket.yemek_fiyat ?? "0") ₺"
        foodNameLabel.text = basket.yemek_adi
        foodQuantityLabel.text = "Adet : \(basket.yemek_siparis_adet ?? "0")"
        if let url = URL(string: "http://kasimadalan.pe.hu/yemekler/resimler/\(basket.yemek_resim_adi ?? "")") {
            DispatchQueue.main.async {
                self.foodImage.kf.setImage(with: url)
            } 
        }
        guard let price = Int(basket.yemek_fiyat ?? "0"),let quantity = Int(basket.yemek_siparis_adet ?? "0") else {return}
        totalPriceLabel.text = "\(price * quantity) ₺"
        
        basketItemContainerCell.layer.borderWidth = 1
        basketItemContainerCell.layer.borderColor = UIColor.orange.cgColor
        basketItemContainerCell.layer.cornerRadius = 12
    }

    @IBAction func removeBasketItemDidTapped(_ sender: Any) {
        guard let index = indexPath, let delegate = delegate else {return}
        delegate.removetoBasketItem(index: index)
    }
}
