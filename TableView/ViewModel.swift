//
//  ViewModel.swift
//  TableView
//
//  Created by 소하 on 2022/06/16.
//

import UIKit

//MARK: - ViewModel
class ViewModel : NSObject {
    var ViewList: [CellData] {
        get {
            return rankList
        }
    }
    
    private let viewList : [CellData] = [
        CellData("Pool", "A", 10000),
        CellData("Bridge", "B", 20000),
        CellData("Sneakers", "C", 30000),
        CellData("Shoes", "D", 40000),
        CellData("Cactus", "E", 50000),
        CellData("Flower", "F", 60000),
        CellData("Bag", "G", 70000),
        CellData("Typing", "H", 80000),
        CellData("Bed", "I", 90000),
        CellData("All", "J", 99999)
    ]
    
    private var rankList : [CellData] {
        let sortedList = viewList.sorted(by: { prev, next in return prev.price > next.price })
        return sortedList
    }
}

//MARK: - DetailViewModel
class DetailViewModel {
    var SenderData : (index: IndexPath, data: CellData, method: ())? {
        get {
            return senderData
        }
        set {
            senderData = newValue
        }
    }
    private var senderData : (index: IndexPath, data: CellData, method: ())?
}
