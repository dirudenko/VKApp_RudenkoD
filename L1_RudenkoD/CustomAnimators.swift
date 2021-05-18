//
//  CustomPushAnimator.swift
//  VKapp_RudenkoD
//
//  Created by Dmitry on 05.05.2021.
//

import UIKit

final class CustomPushAnimator: NSObject, UIViewControllerAnimatedTransitioning {
  func transitionDuration(using transitionContext: UIViewControllerContextTransitioning?) -> TimeInterval {
    return 1.0
  }
  
  func animateTransition(using transitionContext: UIViewControllerContextTransitioning) {
    guard let source = transitionContext.viewController(forKey: .from) else { return }
    guard let destination = transitionContext.viewController(forKey: .to) else { return }
    
    transitionContext.containerView.addSubview(destination.view)
    destination.view.frame = source.view.frame
    let translation  = CGAffineTransform(translationX: source.view.frame.width, y: -source.view.frame.height / 2)
    let rotation  = CGAffineTransform(rotationAngle: -45)
    destination.view.transform = rotation.concatenating(translation)
    UIView.animateKeyframes(withDuration: self.transitionDuration(using: transitionContext),
                            delay: 0,
                            options: .calculationModeCubicPaced,
                            animations: {
                              UIView.addKeyframe(withRelativeStartTime: 0,
                                                 relativeDuration: 0.35,
                                                 animations: { [weak source] in
                                                  guard let source = source else {return}
                                                  let translation  = CGAffineTransform(translationX: -source.view.frame.width / 2 , y: 0)
                                                  let rotation  = CGAffineTransform(rotationAngle: 45)
                                                  //let translation = CGAffineTransform(translationX: -200, y: 0)
                                                 // let scale = CGAffineTransform(scaleX: 0.8, y: 0.8)
                                                  source.view.transform = translation.concatenating(rotation)
                                                  //source?.view.transform = scale
                                                 })
                              UIView.addKeyframe(withRelativeStartTime: 0.2,
                                                 relativeDuration: 0.4,
                                                 animations: { [weak destination] in
                                                 // guard let source = source else {return}
                                                  let translation = CGAffineTransform(translationX: 0, y: 0)
//                                                  let scale = CGAffineTransform(scaleX: 1.2, y: 1.2)
//                                                  destination.view.transform = translation.concatenating(scale) })
                                  
                                                   let rotate = CGAffineTransform(rotationAngle: 0)
                                                  destination?.view.transform = translation.concatenating(rotate)
                                                 })
                              UIView.addKeyframe(withRelativeStartTime: 0.6,
                                                 relativeDuration: 0.4,
                                                 animations: { [weak destination] in
                                                  destination?.view.transform = .identity
                                                 })
                            }) { finished in
      if finished && !transitionContext.transitionWasCancelled {
        source.view.transform = .identity }
      transitionContext.completeTransition(finished && !transitionContext.transitionWasCancelled)
    }
  }
}

final class CustomPopAnimator: NSObject, UIViewControllerAnimatedTransitioning {
  func transitionDuration(using transitionContext: UIViewControllerContextTransitioning?) -> TimeInterval {
    return 1
  }
  
  func animateTransition(using transitionContext: UIViewControllerContextTransitioning) {
    guard let source = transitionContext.viewController(forKey: .from) else { return }
    guard let destination = transitionContext.viewController(forKey: .to) else {return }
    transitionContext.containerView.addSubview(destination.view)
    transitionContext.containerView.sendSubviewToBack(destination.view)
    destination.view.frame = source.view.frame
    let translation  = CGAffineTransform(translationX: -source.view.frame.width / 2 , y: 0)
    let rotation  = CGAffineTransform(rotationAngle: 45)
    destination.view.transform = translation.concatenating(rotation)
    UIView.animateKeyframes(withDuration: self.transitionDuration(using: transitionContext),
                            delay: 0,
                            options: .calculationModeCubicPaced,
                            animations: {
                              UIView.addKeyframe(withRelativeStartTime: 0,
                                                 relativeDuration: 0.35,
                                                 animations: { [weak source] in
                                                  guard let source = source else {return}
                                                  let translation  = CGAffineTransform(translationX: source.view.frame.width, y: -source.view.frame.height / 2)
                                                  let rotation  = CGAffineTransform(rotationAngle: -45)
                                                  //let translation = CGAffineTransform(translationX: -200, y: 0)
                                                 // let scale = CGAffineTransform(scaleX: 0.8, y: 0.8)
                                                  source.view.transform = rotation.concatenating(translation)
                                                 })
                              UIView.addKeyframe(withRelativeStartTime: 0.2,
                                                 relativeDuration: 0.75,
                                                 animations: { [weak destination] in
                                                 // guard let source = source else {return}
                                                  //let translation  = CGAffineTransform(translationX: source.view.frame.width, y: 0 )
                                                  let rotation  = CGAffineTransform(rotationAngle: 0)
                                                  destination?.view.transform = translation.concatenating(rotation)
                                                 })
                              UIView.addKeyframe(withRelativeStartTime: 0.6,
                                                 relativeDuration: 0.4,
                                                 animations: { [weak destination] in
                                                  destination?.view.transform = .identity
                                                 })
                            }) { finished in
      if finished && !transitionContext.transitionWasCancelled {
        source.view.transform = .identity }
      transitionContext.completeTransition(finished && !transitionContext.transitionWasCancelled)
    }
    
  }
}
