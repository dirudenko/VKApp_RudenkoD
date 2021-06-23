//
//  CustomNavigationController.swift
//  VKapp_RudenkoD
//
//  Created by Dmitry on 05.05.2021.
//

import UIKit

class CustomNavigationController: UINavigationController, UINavigationControllerDelegate {
 
  let interactiveTransition = NavigationClosingAnimation()
  
  override func viewDidLoad() {
    super.viewDidLoad()
    delegate = self
  }
  
  func navigationController(_ navigationController: UINavigationController, interactionControllerFor animationController: UIViewControllerAnimatedTransitioning) -> UIViewControllerInteractiveTransitioning? {
    return interactiveTransition.hasStarted ? interactiveTransition : nil
  }
  
  func navigationController(_ navigationController: UINavigationController, animationControllerFor operation: UINavigationController.Operation, from fromVC: UIViewController, to toVC: UIViewController) -> UIViewControllerAnimatedTransitioning? {
    
    if operation == .push {
      self.interactiveTransition.viewController = toVC
      return CustomPushAnimator()
    }
    else if operation == .pop {
      
      if fromVC is DetailedFriendCollectionViewController {
        if Session.shared.userId.count > 1 {
        Session.shared.userId.removeLast()
        }
      }
        if navigationController.viewControllers.first != toVC {
          self.interactiveTransition.viewController = toVC
        }
        return CustomPopAnimator()
      }
    return nil
  }
}


