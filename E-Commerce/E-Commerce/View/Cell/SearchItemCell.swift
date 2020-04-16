//
//  SearchItemCell.swift
//  E-Commerce
//
//  Created by Adi Wibowo on 16/04/20.
//  Copyright © 2020 Adi Wibowo. All rights reserved.
//

import UIKit

class SearchItemCell: UITableViewCell {

    @IBOutlet weak var lblPrice: UILabel!
    @IBOutlet weak var lblName: UILabel!
    @IBOutlet weak var imgItem: UIImageView!
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
    func bind(promoItem : PromoItem) {
        if let urlImage = promoItem.imageUrl, let url = NSURL(string: urlImage){
            imgItem.af_setImage(withURL: url as URL, placeholderImage: UIImage(named: "google"), filter: nil, progress: nil, imageTransition: .crossDissolve(0.3), runImageTransitionIfCached: true, completion: nil)
        }
        
        if let title = promoItem.title {
            lblName.text = title
        }
        
        if let price = promoItem.price {
            lblPrice.text = price
        }
        
    }
    
}
