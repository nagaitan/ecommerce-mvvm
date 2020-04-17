//
//  DetailVC.swift
//  E-Commerce
//
//  Created by Adi Wibowo on 16/04/20.
//  Copyright © 2020 Adi Wibowo. All rights reserved.
//

import UIKit

class DetailVC: UIViewController {

    @IBOutlet weak var lblPrice: UILabel!
    @IBOutlet weak var lblName: UILabel!
    @IBOutlet weak var txtDescription: UITextView!
    @IBOutlet weak var imgItem: UIImageView!
    @IBOutlet weak var btnLoved: UIButton!
    let viewModel = DetailViewModel()
    
    var item : PromoItem!
    
    static func initiate(item : PromoItem) -> DetailVC{
        let cont = DetailVC()
        cont.item = item
        return cont
    }
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        print("Isi Item \(item)")
        setupView()
    }
    
    func setupView(){
        viewModel.delegate = self
        if item.loved == 1 {
            btnLoved.setImage(UIImage(systemName: "heart.fill"), for: .normal)
        }else{
            btnLoved.setImage(UIImage(systemName: "heart"), for: .normal)
        }
        if let name = item.title{
            lblName.text = name
        }
        if let price = item.price {
            lblPrice.text = price
        }
        if let des = item.descriptions {
            txtDescription.text = des
        }
        if let urlImage = item.imageUrl, let url = NSURL(string: urlImage){
                  imgItem.af_setImage(withURL: url as URL, placeholderImage: UIImage(named: "google"), filter: nil, progress: nil, imageTransition: .crossDissolve(0.3), runImageTransitionIfCached: true, completion: nil)
              }
        
    }
    @IBAction func goLoved(_ sender: UIButton) {
        viewModel.likeItem(vc: self)
    }
    
    @IBAction func goBack(_ sender: Any) {
        self.navigationController?.popViewController(animated: true)
    }

    @IBAction func goBuy(_ sender: Any) {
        viewModel.purchaseItem(item: item)
    }
    
    @IBAction func goShare(_ sender: Any) {
        viewModel.shareItem(vc: self, item: item)
    }
}

extension DetailVC : DetailViewDelegate{
    func doneBuy() {
        self.navigationController?.popViewController(animated: true)
    }
}
