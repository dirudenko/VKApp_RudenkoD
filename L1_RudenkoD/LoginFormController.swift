//
//  LoginFormController.swift
//  L1_RudenkoD
//
//  Created by Dmitry on 03.04.2021.
//

import UIKit

class LoginFormController: UIViewController {
  
  private let fromLoginToTabbbarSegue = "fromLoginToTabbbarSegue"
  
  @IBOutlet weak var loginInput: UITextField!
  @IBOutlet weak var passwordInput: UITextField!
  @IBOutlet weak var loginInterface: UIScrollView!
  
  @IBOutlet weak var animationView: UIView!
  @IBOutlet weak var loadingImage1: UIImageView!
  
  @IBOutlet weak var loadingImage2: UIImageView!
  
  @IBOutlet weak var loadingImage3: UIImageView!
  
  func checkUser() -> Bool {
    let login = "admin"
    let password = "admin"
    guard self.loginInput.text?.trimmingCharacters(in: .whitespacesAndNewlines) == login,
          self.passwordInput.text?.trimmingCharacters(in: .whitespacesAndNewlines) == password else { return false }
    return true
  }
  
  func showLoginError() {
    let action = UIAlertAction(title: "OK", style: .cancel, handler: nil)
    let alert = UIAlertController(title: "Ошибка", message: "Неверное имя пользователя или пароль", preferredStyle: UIAlertController.Style.alert)
    alert.addAction(action)
    present(alert, animated: true, completion: {
      self.loginInput.text = ""
      self.passwordInput.text = ""
    })
  }
  
//  override func shouldPerformSegue(withIdentifier identifier: String, sender: Any?) -> Bool {
//    let checkResult = checkUser()
//    if !checkResult {
//      showLoginError()
//    }
//    return checkResult
//  }
  
  override func viewDidLoad() {
    super.viewDidLoad()
    let tapGesture = UITapGestureRecognizer(target: view, action: #selector(UIView.endEditing))
    view.addGestureRecognizer(tapGesture)
   // animateLogo()    
  }
  
  @IBAction func loginButton(_ sender: UIButton) {
  }
}

extension LoginFormController {
  func animateLogo() {
    self.view.bringSubviewToFront(animationView)
    UIView.animate(withDuration: 0.6,
                   delay: 0,
                   options: [.curveEaseIn],
                   animations: {[ weak self] in
                    self?.loadingImage3.alpha = 0.0
                   },
                   completion: {_ in
                    UIView.animate(withDuration: 0.6,
                                   delay: 0,
                                   options: [.curveEaseIn],
                                   animations: {[ weak self] in
                                    self?.loadingImage2.alpha = 0.0
                                   },
                                   completion: {_ in
                                    UIView.animate(withDuration: 0.6,
                                                   delay: 0,
                                                   options: [.curveEaseIn],
                                                   animations: {[ weak self] in
                                                    self?.loadingImage1.alpha = 0.0
                                                   },
                                                   completion: {_ in
                                                    UIView.transition(from: self.animationView,
                                                                      to: self.loginInterface,
                                                                      duration: 1,
                                                                      options: [.transitionFlipFromBottom],
                                                                      completion: nil)
                                                   })
                                   })
                   })
  
  }
}
