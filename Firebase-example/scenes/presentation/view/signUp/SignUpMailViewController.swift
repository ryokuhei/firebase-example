//
//  SignUpMailViewController.swift
//  Shine_for_iOS
//
//  Created by ryoku on 2018/02/03.
//  Copyright © 2018 ryoku. All rights reserved.
//

import Foundation
import UIKit

class SignUpMailViewController: UIViewController {
    
    @IBOutlet weak var mailAddress: CustomTextField!
    @IBOutlet weak var mailError: UILabel!
    @IBOutlet weak var nextButton: CustomButton!
    
    @IBAction func mailEditting(_ sender: Any) {
        hideErrorMessage(label: .mail)
        presenter!.mail = mailAddress.text
        presenter!.stateMailNextButton()
    }

    var presenter: SignUpPresenter?  {
        didSet {
            presenter?.delegate = self
        }
    }

    lazy var activeIndicator : UIActivityIndicatorView = {
        let activeIndicator = UIActivityIndicatorView(activityIndicatorStyle: UIActivityIndicatorViewStyle.whiteLarge)
        activeIndicator.backgroundColor = UIColor(white: 0, alpha: Alpha.disable)
        activeIndicator.frame = navigationController?.view.bounds ?? view.bounds
        
        return activeIndicator
    }()
    
    static func createViewController() ->UIViewController {
        let vc = Segue.signUpMail.instantiateInitialViewController()
        return vc
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        mailAddress?.delegate = self

        presenter?.stateMailNextButton()
        
        navigationController?.view.addSubview(activeIndicator)
    }
    
    // view touches to close keybourd
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        super.touchesBegan(touches, with: event)
        
        view.endEditing(true)
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == Segue<SignUpUserViewController>.signUpUser.identity {
            let signUpUsserVC = segue.destination as? SignUpUserViewController
            signUpUsserVC?.presenter = self.presenter
        }
    }
    
    override func shouldPerformSegue(withIdentifier identifier: String, sender: Any?) -> Bool {
        return presenter!.validMail()
    }
}

extension SignUpMailViewController: UITextFieldDelegate {
    // tapped enter to close keyboard
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        textField.resignFirstResponder()
        return true
    }
}

extension SignUpMailViewController: SignUpDelegate {
    

    func buttonEnable() {
        nextButton.isEnabled = true
        nextButton.alpha = Alpha.enable
    }
    
    func buttonDisabe() {
        nextButton.isEnabled = false
        nextButton.alpha = Alpha.disable
    }
    
    func showErrorMessage(label: SignUpLabel, errMsg: String) {
        switch label {
        case .mail :
            mailError.text = errMsg
            mailAddress.layer.borderColor = UIColor.MyTheme.error.cgColor
        default:
            break
        }
    }
    
    func hideErrorMessage(label: SignUpLabel) {

        switch label {
        case .mail :
            mailError.text = nil
            mailAddress.layer.borderColor = UIColor.MyTheme.textBorder.cgColor
        default:
            break
        }
    }

    func showActivityIndicator() {
        activeIndicator.startAnimating()
    }
    
    func stopActivityIndicator() {
        activeIndicator.stopAnimating()
    }
    
    func showErrorAlert(errMsg: String) {
        activeIndicator.stopAnimating()
        let alert = UIAlertController(title: "error", message: errMsg, preferredStyle: .alert)
        let okAction = UIAlertAction(title: "ok", style: .default)
        
        alert.addAction(okAction)
        
        self.present(alert, animated: true, completion: nil)
    }
    
    func gotoTopViewController() {
        activeIndicator.stopAnimating()
        AppDelegate.shared.rootViewController.showTopScreen()
    }
}
