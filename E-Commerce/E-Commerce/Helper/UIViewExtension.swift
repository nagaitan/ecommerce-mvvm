//
//  UIViewExtension.swift
//  E-Commerce
//
//  Created by Adi Wibowo on 17/04/20.
//  Copyright © 2020 Adi Wibowo. All rights reserved.
//

import Foundation
import UIKit

extension UIView {
    func cardify(color : CGColor = UIColor.black.cgColor) {
        layer.cornerRadius = 3
        layer.shadowColor = UIColor.black.cgColor
        layer.shadowOpacity = 0.5
        layer.shadowOffset = CGSize(width: 0, height: 1)
        layer.shadowRadius = 1
    }
}
