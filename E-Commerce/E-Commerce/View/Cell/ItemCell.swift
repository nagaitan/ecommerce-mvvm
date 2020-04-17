//
//  ItemCell.swift
//  E-Commerce
//
//  Created by Adi Wibowo on 16/04/20.
//  Copyright © 2020 Adi Wibowo. All rights reserved.
//

import UIKit

class ItemCell: UITableViewCell {

    @IBOutlet weak var imgLoved: UIImageView!
    @IBOutlet weak var lblItemName: UILabel!
    @IBOutlet weak var imgItem: UIImageView!
    @IBOutlet weak var containerView: UIView!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
        containerView.cardify()
        // Configure the view for the selected state
    }
    
    func bind(promoItem : PromoItem) {
        if let urlImage = promoItem.imageUrl, let url = NSURL(string: urlImage){
            imgItem.af_setImage(withURL: url as URL, placeholderImage: UIImage(named: "google"), filter: nil, progress: nil, imageTransition: .crossDissolve(0.3), runImageTransitionIfCached: true, completion: nil)
        }
        
        if let title = promoItem.title {
            lblItemName.text = title
        }
        
        if promoItem.loved == 1 {
            imgLoved.image = UIImage(systemName: "heart.fill")
        }else{
            imgLoved.image = UIImage(systemName: "heart")
        }
        
    }
    
}
