//
//  BasketVC.swift
//  OrderApp
//
//  Created by Güven Boydak on 1.10.2023.
//

import UIKit

final class BasketVC: UIViewController {
    @IBOutlet weak var totalContainerView: UIView!
    @IBOutlet weak var totalPriceLabel: UILabel!
    @IBOutlet weak var basketTableView: UITableView!
    @IBOutlet weak var conformToBasketButton: UIButton!
    var basketList = [FoodInBasket]()
    var basketVM = BasketViewModel()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        basketTableView.dataSource = self
        basketTableView.delegate = self
        
        
    }
    override func viewWillAppear(_ animated: Bool) {
        basketVM.getBasketFood()
        _ = basketVM.baskets.subscribe(onNext: { basketList in
            self.basketList = basketList
            DispatchQueue.main.async {
                self.basketTableView.reloadData()
            }
            self.calculateTotalPrice()
        })
    }
    
    func calculateTotalPrice() {
        totalContainerView.layer.borderWidth = 1
        totalContainerView.layer.borderColor = UIColor.orange.cgColor
        totalContainerView.layer.cornerRadius = 8
        conformToBasketButton.layer.cornerRadius = 8
        
        var total = 0
        for food in basketList {
            if let foodPrice = Int(food.yemek_fiyat ?? "0"),let quantity = Int(food.yemek_siparis_adet ?? "0") {
                total = total + (foodPrice * quantity)
                totalPriceLabel.text = "\(total) ₺"
            }
        }
    }

    @IBAction func conformToBasketDidTapped(_ sender: Any) {
        let alertControler = UIAlertController(title: "Tebrikler", message: "Siparisleriniz Alindi Tesekkurler", preferredStyle: .alert)
        let cencelAction = UIAlertAction(title: "Tamam", style: .cancel)
        alertControler.addAction(cencelAction)
        present(alertControler, animated: true)
    }
}

extension BasketVC: UITableViewDelegate,UITableViewDataSource,RemoveToBasketItemProtocol {
    
    func removetoBasketItem(index: IndexPath) {
        guard let basketId = basketList[index.row].sepet_yemek_id,let id = Int(basketId) else {return}
        basketVM.deleteFoodToBasket(id: id)
        let foodInBasket = basketList[index.row]
        basketVM.addFirebasedeletedItem(foodInBaseket: foodInBasket)
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        basketList.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "BasketCell") as! BasketCell
        let basket = basketList[indexPath.row]
        cell.setupCell(basket: basket)
        cell.delegate = self
        cell.indexPath = indexPath
        return cell
    }
}
