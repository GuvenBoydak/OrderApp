//
//  profileBasketDetailCell.swift
//  OrderApp
//
//  Created by Güven Boydak on 1.10.2023.
//

import UIKit

final class profileBasketDetailCell: UITableViewCell {

    @IBOutlet weak var detailBasketContainerView: UIView!
    @IBOutlet weak var foodNameLabel: UILabel!
    @IBOutlet weak var foodPriceLabel: UILabel!
    @IBOutlet weak var foodStatusLabel: UILabel!
 
    override func awakeFromNib() {
        super.awakeFromNib()
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
    }
    
    func setupCell(detailBasket: DetailBasket) {
        detailBasketContainerView.layer.borderWidth = 1
        detailBasketContainerView.layer.borderColor = UIColor.systemOrange.cgColor
        detailBasketContainerView.layer.cornerRadius = 10
        
        if let name = detailBasket.name, let price = detailBasket.price, let status = detailBasket.status {
            foodNameLabel.text = name
            foodPriceLabel.text = "\(price) ₺"
            foodStatusLabel.text = status
        }
    }
}
