//
//  CategoryItemCell.swift
//  E-Commerce
//
//  Created by Adi Wibowo on 16/04/20.
//  Copyright © 2020 Adi Wibowo. All rights reserved.
//

import UIKit

class CategoryItemCell: UICollectionViewCell {
    @IBOutlet weak var imgItem: UIImageView!
    @IBOutlet weak var lblName: UILabel!
    @IBOutlet weak var containerView: UIView!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        containerView.cardify()
    }
    
    func bind(cat : Category){
        if let urlImage = cat.imageUrl, let url = NSURL(string: urlImage){
            imgItem.af_setImage(withURL: url as URL, placeholderImage: UIImage(named: "google"), filter: nil, progress: nil, imageTransition: .crossDissolve(0.3), runImageTransitionIfCached: true, completion: nil)
        }
        
        if let name = cat.name {
            lblName.text  = name
        }
    }

}
