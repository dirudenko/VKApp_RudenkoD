//
//  LoginFormController.swift
//  L1_RudenkoD
//
//  Created by Dmitry on 03.04.2021.
//

import UIKit

class LoginFormController: UIViewController {
  let fromLoginToTabbbarSegue = "fromLoginToTabbbarSegue"
  
  @IBOutlet weak var loginInput: UITextField!
  @IBOutlet weak var passwordInput: UITextField!
  
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
  
  override func shouldPerformSegue(withIdentifier identifier: String, sender: Any?) -> Bool {
    let checkResult = checkUser()
    if !checkResult {
      showLoginError()
    }
    return checkResult
  }
  
  override func viewDidLoad() {
    super.viewDidLoad()
    let tapGesture = UITapGestureRecognizer(target: view, action: #selector(UIView.endEditing))
    view.addGestureRecognizer(tapGesture)
    
  }
  
  @IBAction func loginButton(_ sender: UIButton) {
  }
}

