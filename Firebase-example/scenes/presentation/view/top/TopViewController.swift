//
//  TopViewController.swift
//  Shine_for_iOS
//
//  Created by ryoku on 2018/01/11.
//  Copyright © 2018 ryoku. All rights reserved.
//

import Foundation
import UIKit
import Firebase

protocol TopDelegate: class {
    func reloadTableView(userModels: [UserModel])
    func showErrorAlert(errMsg: String)
    func pushDetailViewController(id: String)
    func pushCreateViewController()
    func showIndicator()
    func stopIndicator()
}

class TopViewController: UIViewController {
    
    @IBOutlet weak var tableView: NameTableView!
    @IBOutlet weak var signOut: UIButton!
    
    var presenter: TopPresenter? {
        didSet {
            presenter?.delegate = self
        }

    }
    static func createViewController() ->TopViewController {
        let topVC = Segue<TopViewController>.top.instantiateInitialViewController()
        return topVC
    }
    
    lazy var activityIndicator: UIActivityIndicatorView = {
        let indicator = UIActivityIndicatorView(activityIndicatorStyle: UIActivityIndicatorViewStyle.whiteLarge)
        indicator.frame = navigationController?.view.bounds ?? view.bounds
        indicator.backgroundColor = UIColor(white: 0, alpha: 0.4)
        
        return indicator
    }()

    override func viewDidLoad() {
       super.viewDidLoad()
        print("viewController viewDidLoad")

        tableView.dataSource = tableView
        tableView.delegate = tableView
        tableView.presenter = self.presenter
        
        let addButton = UIBarButtonItem(barButtonSystemItem: .add, target: self, action: #selector(addButtonDidPush))
        self.navigationController?.view.addSubview(activityIndicator)
        navigationItem.setRightBarButton(addButton, animated: true)
        
        signOut.addTarget(self, action: #selector(signOutUser), for: .touchUpInside)
        

        presenter?.loadUserList()
        
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        // cellの選択解除
        if let selectedCell = self.tableView.indexPathForSelectedRow {
            self.tableView.deselectRow(at: selectedCell, animated: true)
        }
        
    }

    @objc func signOutUser() {
        do {
           try Auth.auth().signOut()
        } catch  {
            print("logoutError")
        }
        AppDelegate.shared.rootViewController.showLoginScreen()
    }
    
    @objc func addButtonDidPush() {
        presenter?.addButtonDidPush()
    }
}

extension TopViewController: TopDelegate {

    
    func showIndicator() {
        activityIndicator.startAnimating()
    }
    
    func stopIndicator() {
        activityIndicator.stopAnimating()
    }
    
    func reloadTableView(userModels: [UserModel]) {
        self.tableView.userList = userModels
        self.tableView.reloadData()
    }
    
    func showErrorAlert(errMsg: String) {
        
        let alert = UIAlertController(title: "Error", message: errMsg, preferredStyle: UIAlertControllerStyle.alert)
        let okAction = UIAlertAction(title: "ok", style: .default)
        alert.addAction(okAction)
        
        self.present(alert, animated: true, completion: nil)
        
    }
    
    func pushDetailViewController(id: String) {
        
        DetailViewControllerBuilder.id = id
        let detailVC = DetailViewControllerBuilder.build()
        self.navigationController?.pushViewController(detailVC, animated: true)
    }
    
    func pushCreateViewController() {
        
        let vc = CreateViewControllerBuilder.build()
        self.navigationController?.pushViewController(vc, animated: true)
    }
}
