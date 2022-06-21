//
//  DetailViewController.swift
//  TableView
//
//  Created by 소하 on 2022/06/15.
//

import UIKit

//MARK: - View
class DetailViewController: UIViewController {
    let detailViewMoel = DetailViewModel()
    
    @IBOutlet weak var imgView: UIImageView!
    @IBOutlet weak var labelName: UILabel!
    @IBOutlet weak var labelPrice: UILabel!
    
    @IBOutlet weak var namePos: NSLayoutConstraint!
    @IBOutlet weak var pricePos: NSLayoutConstraint!
    
    override func viewDidLoad() {
        super.viewDidLoad()
//        posY = (namePos.constant, pricePos.constant)
        
        updateUI()
        prepareAnim()
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        
        playAnim()
    }
    
    func updateUI() {
        if let data = detailViewMoel.SenderData {
            imgView.image = data.data.imgPath
            labelName.text = data.data.name
            
            let number = NumberFormatter()
            number.numberStyle = .decimal
            labelPrice.text = "₩\(number.string(from: data.data.price as NSNumber) ?? "0")"
        }
    }
    
    func prepareAnim() {
//        namePos.constant = view.bounds.height
//        pricePos.constant = view.bounds.height
        labelName.transform = CGAffineTransform(translationX: 0, y: view.bounds.height).scaledBy(x: 2, y: 2)
        labelName.alpha = 0
        labelPrice.transform = CGAffineTransform(translationX: 0, y: view.bounds.height).scaledBy(x: 2, y: 2)
        labelPrice.alpha = 0
    }
    
    func playAnim() {
        UIView.transition(with: imgView, duration: 0.3, options: .transitionFlipFromLeft, animations: nil) { isEnd in
            if isEnd {
                UIView.animate(withDuration: 0.5, delay: 0, usingSpringWithDamping: 0.6, initialSpringVelocity: 1, options: .curveEaseOut) {
                    self.labelName.transform = CGAffineTransform.identity
                    self.labelName.alpha = 1
                    self.labelPrice.transform = CGAffineTransform.identity
                    self.labelPrice.alpha = 1
                }
            }
        }
    }
    
    @IBAction func BtnClose(_ sender: Any) {
        dismiss(animated: true, completion: nil)
    }
}
