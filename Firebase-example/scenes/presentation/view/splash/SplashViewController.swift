//
//  SplashViewController.swift
//  Shine_for_iOS
//
//  Created by ryoku on 2018/01/27.
//  Copyright © 2018 ryoku. All rights reserved.
//

import Foundation
import UIKit

protocol SplashDelegate: class {
    func gotoTopView()
    func gotoLoginView()
}
class SplashViewController: UIViewController {
    
    @IBOutlet weak var icon: UIImageView!

    var presenter: SplashPresenter? {
        didSet {
            presenter?.delegate = self
        }
    }

    static func createViewController() ->SplashViewController {
        
        let vc = Segue<SplashViewController>.splash.instantiateInitialViewController()
        return vc
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.presenter?.loginCheck()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        print("view Will Appear of Splash ViewController")
    }
    
    override func viewDidAppear(_ animated: Bool) {
        
        super.viewDidAppear(animated)
        print("view Did Appear of Splash ViewController")
    }

    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        print("view Will Disappear of Splash ViewController")
    }
    
    override func viewDidDisappear(_ animated: Bool) {
        super.viewDidDisappear(animated)
        print("view Did Disappear of Splash ViewController")
    }
    
    deinit {
        print("deinit of Splash ViewController")
    }
    
}

extension SplashViewController: SplashDelegate {
    
    func gotoTopView() {
        feedOutAnimation {
            AppDelegate.shared.rootViewController.showTopScreen()
        }
    }
    
    func gotoLoginView() {
        feedOutAnimation {
            AppDelegate.shared.rootViewController.showLoginScreen()
        }
    }
    
    func feedOutAnimation(completion: @escaping () ->Void) {
        DispatchQueue.main.async {
        UIView.animate(withDuration: 1,
            animations: { [weak self] in
                self?.icon.alpha = 0
            }, completion: {finised in
                completion()
            })
        }
    }
    
}


