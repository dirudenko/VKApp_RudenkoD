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
  @IBOutlet weak var viewForCloud: UIView!
  
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
    animateLogo()
  }
  
  @IBAction func loginButton(_ sender: UIButton) {
  }
}

extension LoginFormController {
  
  func animateLogo() {
    self.view.bringSubviewToFront(animationView)
    
    CATransaction.setCompletionBlock{ [weak self] in
      UIView.transition(from: self!.animationView,
                        to: self!.loginInterface,
                        duration: 1,
                        options: [.transitionFlipFromBottom],
                        completion: nil)
    }
    
    let shapeLayer = CAShapeLayer()
    shapeLayer.path = createBezierPath().cgPath
    shapeLayer.strokeColor = UIColor.systemBlue.cgColor
    shapeLayer.fillColor = UIColor.white.cgColor
    shapeLayer.lineWidth = 3.0
    viewForCloud.layer.addSublayer(shapeLayer)
    let circleLayer = CAShapeLayer()
    circleLayer.backgroundColor = UIColor.black.cgColor
    circleLayer.bounds = CGRect(x: 0, y: 0, width: 10, height: 10)
    circleLayer.cornerRadius = 5

    let followPathAnimation = CAKeyframeAnimation(keyPath: "position")
    followPathAnimation.path = createBezierPath().cgPath
    followPathAnimation.calculationMode = CAAnimationCalculationMode.cubicPaced
    followPathAnimation.speed = 0.1
    followPathAnimation.repeatCount = 2
    circleLayer.add(followPathAnimation, forKey: nil)
    viewForCloud.layer.addSublayer(circleLayer)
  }
  
  func createBezierPath() -> UIBezierPath {
    let path = UIBezierPath()
    path.move(to: CGPoint(x: 15, y: 85))
    path.addLine(to: CGPoint(x: 85, y: 85))
    path.addArc(withCenter: CGPoint(x: 85, y: 75),
                radius: 10,
                startAngle: 45 ,
                endAngle: 180,
                clockwise: false)
    path.addArc(withCenter: CGPoint(x: 68, y: 60),
                radius: 13,
                startAngle: 0,
                endAngle: 110,
                clockwise: false)
    path.addArc(withCenter: CGPoint(x: 35, y: 55),
                radius: 20,
                startAngle: 0,
                endAngle: 280,
                clockwise: false)
    path.addArc(withCenter: CGPoint(x: 15, y: 70),
                radius: 15,
                startAngle: CGFloat(80) ,
                endAngle: CGFloat(310),
                clockwise: false)
    path.close()
    return path
  }
}
