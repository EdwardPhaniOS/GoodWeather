//
//  TableViewDataSource.swift
//  GoodWeather
//
//  Created by Tan Vinh Phan on 5/11/20.
//  Copyright © 2020 PTV. All rights reserved.
//

import Foundation
import UIKit

//Create Custom GenericDatasource (phuc vu nhieu tableview cua 1 hoac nhieu nguoi trong project --> Han che chinh sua, them bot)

//Ban chat class cung la Cau truc du lieu + Thuat toan
//TableViewDataSource: chua CellType, ViewModel(type) de tinh toan cellForRowAt IndexPath, chua cellIdentifier de dequeueReuse..., chua listItem (items) de tinh toan numberOfRow, cellForRowAt IndexPath
class TableViewDataSource<CellType, ViewModel>: NSObject, UITableViewDataSource where CellType: UITableViewCell {
    
    let cellIdentifier: String
    var items: [ViewModel]
    let configureCell: (CellType, ViewModel) -> Void
    
    init(cellIdentifier: String, items: [ViewModel], configureCell: @escaping (CellType, ViewModel) -> Void) {
        self.cellIdentifier = cellIdentifier
        self.items = items
        self.configureCell = configureCell
    }
    
    func updateItems(_ items: [ViewModel]) {
        self.items = items
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return items.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: self.cellIdentifier, for: indexPath) as? CellType else {
            fatalError("Cell with \(self.cellIdentifier) not found")
        }
        
        let vm = items[indexPath.row]
        self.configureCell(cell, vm)
        
        return cell
    }
    
    
}


