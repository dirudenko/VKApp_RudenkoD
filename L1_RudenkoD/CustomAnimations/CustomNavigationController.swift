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
    // Do any additional setup after loading the view.
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
        if navigationController.viewControllers.first != toVC {
          self.interactiveTransition.viewController = toVC
        }
        return CustomPopAnimator()
      }
    return nil
  }
  /*
   // MARK: - Navigation
   
   // In a storyboard-based application, you will often want to do a little preparation before navigation
   override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
   // Get the new view controller using segue.destination.
   // Pass the selected object to the new view controller.
   }
   */
  
}
