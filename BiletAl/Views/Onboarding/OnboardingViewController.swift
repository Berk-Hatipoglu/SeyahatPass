//
//  OnboardingViewController.swift
//  BiletAl
//
//  Created by Berk Hatipoğlu on 7.05.2023.
//

import UIKit

class OnboardingViewController: UIViewController {
    
    
    @IBOutlet weak var collectionView: UICollectionView!
    @IBOutlet weak var nextBtn: UIButton!
    @IBOutlet weak var pageControl: UIPageControl!

    var slides: [OnboardingSlide] = []
    
    var currentPage = 0 {
        didSet{
            pageControl.currentPage = currentPage
            if currentPage == slides.count - 1 {
                
                nextBtn.setTitle("Başlayalım", for: .normal)
            } else {
                nextBtn.setTitle("İleri", for: .normal)
            }
        }
    }
    
    
    override func viewDidLoad() {
        super.viewDidLoad()

        slides = [
            OnboardingSlide(title: "SeyahatPass      Hoş Geldiniz!", description: "Seyahatlerinizi unutulmaz kılmak için buradayız.", image: "bus-slides"),
            OnboardingSlide(title: "Dilediğiniz gibi Seyehat Edin", description: "Ülkemizin her yerine dilediğiniz zaman seyahat edin", image: "map-slides"),
            OnboardingSlide(title: "Kolay Online Ödeme İmkanı!", description: "Seyahatlerinizi online ödeme ile hızlıca tamamlayın.", image: "card-slides")
        ]
    }
    
    @IBAction func nextBtnClicked(_ sender: Any) {
        
        if currentPage == slides.count - 1 {
                let controller = storyboard?.instantiateViewController(withIdentifier: "HomeNC") as! UINavigationController
                controller.modalPresentationStyle = .fullScreen
                controller.modalTransitionStyle = .flipHorizontal
                present(controller, animated: true, completion: nil)
        } else {
            currentPage += 1
            let indexPath = IndexPath(item: currentPage, section: 0)
            collectionView.scrollToItem(at: indexPath, at: .centeredHorizontally, animated: true)
        }
    }
    
}

extension OnboardingViewController:
    UICollectionViewDelegate,
    UICollectionViewDataSource,
    UICollectionViewDelegateFlowLayout{
    func collectionView(_ collectionView:
    UICollectionView, numberOfItemsInSection
                        section: Int) -> Int{
        return slides.count
    }
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier:OnboardingCollectionViewCell.identifier , for: indexPath) as! OnboardingCollectionViewCell
        cell.setup(slides[indexPath.row])
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: collectionView.frame.width, height: collectionView.frame.height)
    }
    
    func scrollViewDidEndDecelerating(_ scrollView: UIScrollView) {
        let width = scrollView.frame.width
        currentPage = Int(scrollView.contentOffset.x/width)
    }
}
