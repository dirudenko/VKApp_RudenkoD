//
//  FullImageViewController.swift
//  VKapp_RudenkoD
//
//  Created by Dmitry on 06.05.2021.
//

import UIKit

class FullImageViewController: UIViewController {
  
  var indexUser: Int?
  var indexPhoto: Int?
  private var viewTranslation = CGPoint(x: 0, y: 0)
  
  @IBOutlet weak var fullImage: UIImageView!
  
  override func viewDidLoad() {
    super.viewDidLoad()
    fullImage.image = DataStorage.shared.usersArray[indexUser ?? 0].photoArray[indexPhoto ?? 0]
    view.addGestureRecognizer(UIPanGestureRecognizer(target: self, action: #selector(handleDismiss)))
  }
  
  override func viewWillAppear(_ animated: Bool) {
      super.viewWillAppear(animated)
      navigationController?.setNavigationBarHidden(true, animated: animated)
  }

  override func viewWillDisappear(_ animated: Bool) {
      super.viewWillDisappear(animated)
      navigationController?.setNavigationBarHidden(false, animated: animated)
  }
  
  
  @objc func handleDismiss(sender: UIPanGestureRecognizer) {
    switch sender.state {
    case .changed:
      viewTranslation = sender.translation(in: view)
      UIView.animate(withDuration: 0.5,
                     delay: 0,
                     usingSpringWithDamping: 0.7,
                     initialSpringVelocity: 1,
                     options: .curveEaseOut,
                     animations: {[weak self] in
                      self?.view.transform = CGAffineTransform(translationX: 0, y: (self?.viewTranslation.y)!)
                     })
    case .ended:
      if viewTranslation.y < 200 {
        UIView.animate(withDuration: 0.5,
                       delay: 0,
                       usingSpringWithDamping: 0.7,
                       initialSpringVelocity: 1,
                       options: .curveEaseOut,
                       animations: {[weak self] in
                        self?.view.transform = .identity
                       })
      } else {
        //self.navigationController?.popViewController(animated: false)
        dismiss(animated: false,
                completion: {
                  
                 // self.fullImage.alpha = 0
                  //self.fullImage.transform = CGAffineTransform(scaleX: 0.1, y: 0.1)

                })
      }
    default:
      break
    }
  }
}


