//
//  HeaderView.swift
//  E-Commerce
//
//  Created by Adi Wibowo on 16/04/20.
//  Copyright © 2020 Adi Wibowo. All rights reserved.
//

import UIKit

class HeaderView: UIView {

    @IBOutlet weak var lblHeader: UILabel!
    
    /*
    // Only override draw() if you perform custom drawing.
    // An empty implementation adversely affects performance during animation.
    override func draw(_ rect: CGRect) {
        // Drawing code
    }
    */
    
    func setHeader(section : Int) {
        if section == 0 {
            lblHeader.text = "Popular Categories"
        }else{
            lblHeader.text = "Hot Promotions"
        }
        
    }

}
