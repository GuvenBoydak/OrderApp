//
//  ProfileVC.swift
//  OrderApp
//
//  Created by Güven Boydak on 1.10.2023.
//

import UIKit

final class ProfileVC: UIViewController {
    @IBOutlet weak var detailSegment: UISegmentedControl!
    @IBOutlet weak var detailBasketTableView: UITableView!
    
    var profileVM = ProfileViewModel()
    var details = [DetailBasket]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        detailBasketTableView.dataSource = self
        detailBasketTableView.delegate = self
        detailBasketTableView.rowHeight = 70
      
    }
    
    override func viewWillAppear(_ animated: Bool) {
        profileVM.searchDetailBasket(keyword: Shared.sepeteEklenen)
        _ = profileVM.details.subscribe(onNext: { detailList in
            self.details = detailList
            DispatchQueue.main.async {
                self.detailBasketTableView.reloadData()
            }
        })
        detailSegment.addTarget(self, action: #selector(filterDetails(_:)), for: .valueChanged)
    }
    
    @objc func filterDetails(_ sender: UISegmentedControl){
        let selectedIndex = detailSegment.selectedSegmentIndex
        switch selectedIndex {
        case 0 :
            profileVM.searchDetailBasket(keyword: Shared.sepeteEklenen)
        case 1 :
            profileVM.searchDetailBasket(keyword: Shared.sepetenSilinen)
        default :
            profileVM.searchDetailBasket(keyword: Shared.favoriler)
        }
    }
 }

extension ProfileVC: UITableViewDelegate,UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        details.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = detailBasketTableView.dequeueReusableCell(withIdentifier: "ProfileCell",for: indexPath) as! profileBasketDetailCell
        let detailBasket = details[indexPath.row]
        cell.setupCell(detailBasket: detailBasket)
        return cell
    }
}
