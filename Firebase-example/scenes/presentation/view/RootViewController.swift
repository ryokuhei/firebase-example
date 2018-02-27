//  Shine_for_iOS
//
//  Created by ryoku on 2018/01/27.
//  Copyright © 2018 ryoku. All rights reserved.
//

import Foundation
import UIKit

class RootViewController: UIViewController {
    
    private var currentVC: UIViewController
    
    init() {
        currentVC = SplashViewControllerBuilder.build()
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        addChildViewController(currentVC)
        currentVC.view.frame = view.bounds
        view.addSubview(currentVC.view)
        currentVC.didMove(toParentViewController: self)
        
    }
    
    func showTopScreen() {

        let navVC = UINavigationController(rootViewController: TopViewControllerBuilder.build())
//        navVC.navigationBar.setBackgroundImage(UIImage(), for: .default)
//        navVC.navigationBar.shadowImage = UIImage()
        self.changeViewController(vc: navVC)
    }
    
    func showLoginScreen() {

        let navVC = UINavigationController(rootViewController: LoginViewControllerBuilder.build())
        navVC.navigationBar.setBackgroundImage(UIImage(), for: .default)
        navVC.navigationBar.shadowImage = UIImage()
        self.changeViewController(vc: navVC)
    }
    
    private func changeViewController(vc: UIViewController) {
        
        addChildViewController(vc)
        vc.view.frame = view.bounds
        view.addSubview(vc.view)
        vc.didMove(toParentViewController: self)

        print("wll Move of Current ViewCotnroller")
        self.currentVC.willMove(toParentViewController: self)
        print("did Move of Current ViewCotnroller")
        
        print("wll Remove From SuperView of Current ViewCotnroller View")
        self.currentVC.view.removeFromSuperview()
        print("Did Remove From SuperView of Current ViewCotnroller View")
        
        self.currentVC = vc
    }
    
}
