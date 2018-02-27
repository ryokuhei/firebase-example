//
//  NameTableView.swift
//  Firebase-example
//
//  Created by ryoku on 2018/02/16.
//  Copyright © 2018 ryoku. All rights reserved.
//

import Foundation
import UIKit

class NameTableView: UITableView {
    var userList: [UserModel]  = []
    weak var presenter: TopPresenter?

}
extension NameTableView: UITableViewDelegate {
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        presenter?.cellDidTap(user: userList[indexPath.row])
    }
    
    func tableView(_ tableView: UITableView, editActionsForRowAt indexPath: IndexPath) -> [UITableViewRowAction]? {
        let deleteButton = UITableViewRowAction(style: .normal, title: "delete") {
            [unowned self] (action, index) in
            self.presenter?.deleteButtonDidPush(id: self.userList[indexPath.row].id)
        }
        deleteButton.backgroundColor = .red
        
        return [deleteButton]
    }
}


extension NameTableView: UITableViewDataSource {
    

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return userList.count
    }
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell: NameCell = tableView.dequeueReusableCell(withIdentifier: "nameCell", for: indexPath) as! NameCell
        cell.nameLabel.text = userList[indexPath.row].name
        
        return cell
    }
    

}


