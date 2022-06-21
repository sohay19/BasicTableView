//
//  DataModel.swift
//  TableView
//
//  Created by 소하 on 2022/06/16.
//

import UIKit

//MARK: - Model

//기본 CellData
struct CellData {
    var imgPath : UIImage? {
        return UIImage(named: "\(imgName).jpeg")
    }
    var name : String = ""
    var imgName : String = ""
    var price : Int = 0
    
    init(_ name: String, _ img : String, _ price: Int) {
        self.name = name
        self.imgName = img
        self.price = price
    }
}

