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
    var item : PromoItem!
    
    static func initiate(item : PromoItem) -> DetailVC{
        let cont = DetailVC()
        cont.item = item
        return cont
    }
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupView()
    }
    
    func setupView(){
        self.navigationController?.navigationBar.isHidden = true
        if let loved = item.loved, loved == 1 {
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
        if let des = item.description {
            txtDescription.text = des
        }
        if let urlImage = item.imageUrl, let url = NSURL(string: urlImage){
                  imgItem.af_setImage(withURL: url as URL, placeholderImage: UIImage(named: "google"), filter: nil, progress: nil, imageTransition: .crossDissolve(0.3), runImageTransitionIfCached: true, completion: nil)
              }
        
    }
    @IBAction func goLoved(_ sender: UIButton) {
        if let loved = item.loved, loved == 0{
            item.loved = 1
            sender.setImage(UIImage(systemName: "heart.fill"), for: .normal)
        }else{
            item.loved = 0
            sender.setImage(UIImage(systemName: "heart"), for: .normal)
        }
    }
    
    @IBAction func goBack(_ sender: Any) {
        self.navigationController?.popViewController(animated: true)
    }

    @IBAction func goBuy(_ sender: Any) {
        
    }
    @IBAction func goShare(_ sender: Any) {
        let shareText = item.title ?? "Items"

        if let image = imgItem.image {
            let vc = UIActivityViewController(activityItems: [shareText, image], applicationActivities: [])
            present(vc, animated: true)
        }
    }
}
