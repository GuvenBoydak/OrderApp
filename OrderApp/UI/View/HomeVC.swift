//
//  ViewController.swift
//  OrderApp
//
//  Created by Güven Boydak on 1.10.2023.
//

import UIKit
import Kingfisher

final class HomeVC: UIViewController {

    @IBOutlet weak var foodCollectionView: UICollectionView!
    
    var homeVM = HomeViewModel()
    var foods = [Food]()
    var foodInBaskets = [FoodInBasket]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        foodCollectionView.delegate = self
        foodCollectionView.dataSource = self
        setupCollectionFlowLayout()
        
        homeVM.getFoods()
       _ = homeVM.foods.subscribe(onNext: { food in
            self.foods = food
            DispatchQueue.main.async {
                self.foodCollectionView.reloadData()
            }
        })
    }
    
    func setupCollectionFlowLayout() {
        let desing = UICollectionViewFlowLayout()
        
        desing.sectionInset = UIEdgeInsets(top: 10, left: 10, bottom: 10, right: 10)
        desing.minimumLineSpacing = 10
        desing.minimumInteritemSpacing = 10
        
        let width = UIScreen.main.bounds.width
        let itemWidth = (width - 30) / 2
        
        desing.itemSize = CGSize(width: itemWidth, height: itemWidth * 1.1)
        foodCollectionView.collectionViewLayout = desing
    }
}


extension HomeVC : UICollectionViewDelegate,UICollectionViewDataSource,UISearchBarDelegate,HomeFoodCellProtocol {
   
    func addToBasket(indexPath: IndexPath) {
        let basketItem = foodInBaskets[indexPath.row]
        homeVM.addFoodToBasket(food: basketItem)
    }
    
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        if searchText != ""{
            homeVM.searchFoods(keyword: searchText)
        } else {
            homeVM.getFoods()
        }
     }
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        foods.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = foodCollectionView.dequeueReusableCell(withReuseIdentifier: "homeCell", for: indexPath) as! homeFoodCell
        let food = foods[indexPath.row]
        
        cell.setupCell(food: food)
        cell.delegate = self
        cell.index = indexPath
        
        guard let id = food.yemek_id,let name = food.yemek_adi,let image = food.yemek_resim_adi,let price = food.yemek_fiyat, let quantity = cell.foodQuantityLabel.text else {return cell}
        foodInBaskets.append(FoodInBasket(sepet_yemek_id: id, yemek_adi: name, yemek_resim_adi: image, yemek_fiyat: price, yemek_siparis_adet: quantity, kullanici_adi: "Guven"))
        
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let food = foods[indexPath.row]
        performSegue(withIdentifier: "toDetail", sender: food)
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "toDetail" {
            let destVC = segue.destination as! DetailVC
            let food = sender as? Food
            destVC.food = food
        }
    }
}

