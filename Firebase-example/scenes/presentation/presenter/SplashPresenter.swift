//
//  SplashPresenter.swift
//  Shine_for_iOS
//
//  Created by ryoku on 2018/01/27.
//  Copyright © 2018 ryoku. All rights reserved.
//
import Foundation

protocol SplashPresenter {
    
    var delegate: SplashDelegate? {get set}
    
    func loginCheck()
}

class SplashPresenterImpl: BasePresenter, SplashPresenter{
    
    weak var delegate: SplashDelegate?
    
    var loginCheckUseCase: LoginCheckUseCase
    
    init(loginCheck: LoginCheckUseCase) {
        self.loginCheckUseCase = loginCheck
    }
    
    func loginCheck() {

        let result = loginCheckUseCase.invoke()
        
        DispatchQueue.main.asyncAfter(deadline: DispatchTime.now() + 1, execute: { [unowned self] in
            switch result {
                case .success(_):
                    print("go to top view")
                    self.delegate?.gotoTopView()
                case .failure(_):
                    print("go to top login")
                    self.delegate?.gotoLoginView()
            }
        })
    }
}
