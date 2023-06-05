//
//  UIView.swift
//  BiletAl
//
//  Created by Berk Hatipoğlu on 7.05.2023.
//

import UIKit

extension UIView {
    @IBInspectable var cornerRadius: CGFloat {
        get {
            return cornerRadius
        }
        set{
            self.layer.cornerRadius = newValue
        }
    }
}
