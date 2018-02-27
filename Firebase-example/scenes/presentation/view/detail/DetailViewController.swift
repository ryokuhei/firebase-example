//
//  DetailViewController.swift
//  Firebase-example
//
//  Created by ryoku on 2018/02/21.
//  Copyright © 2018 ryoku. All rights reserved.
//

import Foundation
import UIKit

protocol DetailViewDelegate: class {
    func setUserData(user: UserModel)
    func showErrorAlert(message: String)
    func pushEditViewController(id: String)
    func popViewController()
}

class DetailViewController: UIViewController {
    
    var id: String?
    
    @IBOutlet weak var nameLabel: UILabel!
    
    var presenter: DetailPresenter? {
        didSet {
            presenter?.delegate = self
        }
    }
    static func createViewController(id: String) ->DetailViewController {
        let storyboard = UIStoryboard(name: "detail", bundle: nil)
        let vc = storyboard.instantiateInitialViewController() as! DetailViewController
        vc.id = id
        return vc;
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        presenter?.leadUserData(id: id!)
        
        let editButton = UIBarButtonItem(title: "edit", style: .plain, target: self, action: #selector(self.editButtonDidPush))
        self.navigationItem.setRightBarButton(editButton, animated: true)
    }
    
    @objc func editButtonDidPush() {
        presenter?.editButtonDidPush(id: self.id!)
    }
}

extension DetailViewController: DetailViewDelegate {
    
    func setUserData(user: UserModel) {
        
        self.nameLabel.text = user.name
    }
    
    func showErrorAlert(message: String) {
        
        let alert = UIAlertController(title: "error", message: message, preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: "ok", style: .default))
        
        self.present(alert, animated: true, completion: nil)
    }
    
    func pushEditViewController(id: String) {
        
        EditViewControllerBuilder.id = id
        let editVC = EditViewControllerBuilder.build()
        
        self.navigationController?.pushViewController(editVC, animated: true)
    }
    
    func popViewController() {
        
        self.navigationController?.popViewController(animated: true)
    }
}


