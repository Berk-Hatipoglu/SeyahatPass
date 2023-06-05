//
//  QrModel.swift
//  BiletAl
//
//  Created by Berk Hatipoğlu on 18.05.2023.
//

import Foundation
import UIKit

struct QrModel {
    
    var qrImage: UIImage
    
    init(qrImage: UIImage = UIImage()) {
        self.qrImage = qrImage
    }
}
