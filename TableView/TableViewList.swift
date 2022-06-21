//
//  TableViewList.swift
//  TableView
//
//  Created by 소하 on 2022/06/15.
//

import UIKit


//MARK: - ViewController
class TableViewList: UIViewController {
    var clickedIndex : IndexPath?
    let viewModel = ViewModel()
    
    @IBOutlet weak var listView: UICollectionView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "showDetail" {
            let board = segue.destination as? DetailViewController
            
            if let data = sender as? (IndexPath, CellData, ()) {
                board?.detailViewMoel.SenderData = data
            }
        }
    }
    
    //Custom
    func NoneSelect() {
        listView.deselectItem(at: clickedIndex ?? IndexPath(), animated: true)
    }
}

extension TableViewList : UICollectionViewDataSource, UICollectionViewDelegate, UICollectionViewDelegateFlowLayout {
    //DataSource
    //셀 개수
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {        
        return viewModel.ViewList.count
    }
    //셀 표현
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "cell", for: indexPath) as? CustomCell else {
            return UICollectionViewCell()
        }
        cell.updateCell(viewModel.ViewList[indexPath.item])
        return cell
    }
    
    //Delegate
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        clickedIndex = indexPath
        
        let item = viewModel.ViewList[indexPath.item]
        let sendData = CellData(item.name, item.imgName, item.price)
        performSegue(withIdentifier: "showDetail", sender: (indexPath, sendData, NoneSelect()))
    }
    
    //Flow
    //다양한 디바이스에서 일관적인 디자인을 위해 cell Size 계산
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let spacing : CGFloat = 10
        
        let itemWidth : CGFloat = (collectionView.bounds.width - spacing) * 0.5
        let itemHeight : CGFloat = itemWidth + itemWidth * 0.5
        return CGSize(width: itemWidth, height: itemHeight)
    }
}

class CustomCell : UICollectionViewCell {
    @IBOutlet weak var imgView : UIImageView!
    @IBOutlet weak var labelName : UILabel!
    @IBOutlet weak var labelPrice : UILabel!
        
    override func awakeFromNib() {
        self.layer .borderWidth = 0.5
        self.layer.borderColor = UIColor.gray.cgColor
    }
    
    override var isSelected: Bool {
        didSet {
            if isSelected {
                self.layer.borderColor = UIColor.red.cgColor
                self.layer.borderWidth = 3
                self.layer.backgroundColor = UIColor.gray.cgColor
            } else {
                self.layer.borderColor = UIColor.gray.cgColor
                self.layer.borderWidth = 0.5
                self.layer.backgroundColor = nil
            }
        }
    }
    
    func updateCell(_ cellData: CellData) {
        let img = cellData.imgPath
        imgView.image = img
        labelName.text = cellData.name
        
        let number = NumberFormatter()
        number.numberStyle = .decimal
        labelPrice.text = "₩\(number.string(from: cellData.price as NSNumber) ?? "0")"
    }
}
