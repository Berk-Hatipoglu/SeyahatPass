//
//  OnboardingCollectionViewCell.swift
//  BiletAl
//
//  Created by Berk Hatipoğlu on 7.05.2023.
//

import UIKit

class OnboardingCollectionViewCell: UICollectionViewCell {
    
    static let identifier = String(describing: OnboardingCollectionViewCell.self)


    @IBOutlet weak var imageView: UIImageView!
    
    @IBOutlet weak var slideTitleLbl: UILabel!
    @IBOutlet weak var slideDescriptionLbl: UILabel!
    
    func setup(_ slide: OnboardingSlide) {
        imageView.image = UIImage(named: slide.image!)
        slideTitleLbl.text = slide.title
        slideDescriptionLbl.text = slide.description
    }
}
