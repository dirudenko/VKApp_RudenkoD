//
//  Extensions.swift
//  VKapp_RudenkoD
//
//  Created by Dmitry on 25.04.2021.
//

import Foundation
import UIKit

extension UIView {
  
  func avatarAnimation() {
    self.transform = CGAffineTransform(scaleX: 0.1, y: 0.1)
    UIView.animate(withDuration: 0.8,
                   delay: 0,
                   options: .curveEaseOut,
                   animations: { [weak self] in
                    self?.transform = .identity
                   },
                   completion: nil)
  }
  
  func pressLike(isLiked: inout Bool, likeCounter: UILabel, likeButton: UIButton) {
    likeCounterAnimation(likeCounter: likeCounter, isLiked: isLiked)
    likeButtonAnimation(isLiked: isLiked, likeButton: likeButton)
    isLiked = !isLiked
  }
  
  private func likeButtonAnimation(isLiked: Bool ,likeButton: UIButton) {
    likeButton.transform = CGAffineTransform(scaleX: 0.1, y: 0.1)
    UIView.animate(withDuration: 0.5,
                   delay: 0,
                   options: .curveEaseOut,
                   animations: { [weak likeButton] in
                    likeButton?.transform = .identity
                   },
                   completion: nil)
    if isLiked {
      likeButton.setImage(UIImage(systemName: "heart.fill"), for: .normal)
      likeButton.tintColor = UIColor.systemRed
    }
    else {
      likeButton.setImage(UIImage(systemName: "heart"), for: .normal)
      likeButton.tintColor = UIColor.systemBlue
    }
  }
  
  func findButtonAnimation( searchBar: UISearchBar, isAnimated: Bool) {
    if !isAnimated {
      UIView.animate(withDuration: 0.7,
                     delay: 0,
                     usingSpringWithDamping: 0.5,
                     initialSpringVelocity: 0,
                     options: [.curveEaseOut],
                     animations: { [weak self] in
                      self?.frame.origin.x -= (searchBar.frame.width / 2.15)
                      self?.tintColor = #colorLiteral(red: 0.6666666865, green: 0.6666666865, blue: 0.6666666865, alpha: 1)
                     },
                     completion: {_ in
                      UIView.animate(withDuration: 0.5,
                                     animations: {[weak searchBar, self] in
                                      searchBar?.alpha = 1
                                      self.alpha = 0
                                     })
                     })
    }
    else {
      UIView.animate(withDuration: 0.5,
                     delay: 0,
                     animations: {[weak self] in
                      UIView.animate(withDuration: 0.5,
                                     animations: {[weak searchBar, self] in
                                      searchBar?.alpha = 0
                                      self?.alpha = 1
                                     },
                                     
                                     completion: {_ in
                                      UIView.animate(withDuration: 0.5,
                                                     delay: 0,
                                                     usingSpringWithDamping: 0.5,
                                                     initialSpringVelocity: 0,
                                                     options: [.curveEaseOut],
                                                     animations: { [weak self] in
                                                      self?.frame.origin.x += (searchBar.frame.width / 2.15)
                                                      self?.tintColor = UIColor.systemBlue
                                                     })
                                      
                                      
                                     })
                     })
      
    }
  }
  
  func photoAppereance(photoView: UIImageView, isClickedPhoto: inout Bool) {
    if isClickedPhoto {
      UIView.animate(withDuration: 1,
                     delay: 0,
                     options: [.curveEaseInOut],
                     animations: { [weak photoView] in
                      photoView?.alpha = 1
                      photoView?.transform = .identity
                     })
    }
    else {
      UIView.animate(withDuration: 1,
                     delay: 0,
                     options: [.curveEaseInOut],
                     animations: { [weak photoView] in
                      photoView?.alpha = 0.0
                      photoView?.transform = CGAffineTransform(scaleX: 0.1, y: 0.1)
                     })
    }
    isClickedPhoto = !isClickedPhoto
  }
  
  func gradient() {
      clipsToBounds = true
      let gradientLayer = CAGradientLayer()
      gradientLayer.colors = [UIColor.lightGray.cgColor,UIColor.white.cgColor]
      gradientLayer.frame = self.bounds
      gradientLayer.startPoint = CGPoint(x: 0.0, y: 0.0)
      gradientLayer.endPoint = CGPoint(x: 0.7, y: 0.5)
      self.layer.insertSublayer(gradientLayer, at: 0)
   
  }
  
  private func likeCounterAnimation(likeCounter: UILabel, isLiked: Bool) {
    if isLiked {
      UIView.transition(with: likeCounter,
                        duration: 0.5,
                        options: .transitionCurlDown,
                        animations: {   [weak likeCounter] in
                          guard let likeCounter = likeCounter else { return }
                          
                          likeCounter.text = "\(Int(likeCounter.text!)! + 1)"
                          
                        },
                        completion: nil)
    }
    else {
      UIView.transition(with: likeCounter,
                        duration: 0.5,
                        options: .transitionCurlUp,
                        animations: {   [weak likeCounter] in
                          guard let likeCounter = likeCounter else { return }
                          likeCounter.text = "\(Int(likeCounter.text!)! - 1)"
                        },
                        completion: nil)
    }
  }
  
}


