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
    UIView.animate(withDuration: 0.5,
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
    let gradientLayer: CAGradientLayer = {
      let gradientLayer = CAGradientLayer()
      gradientLayer.colors = [UIColor.lightGray.cgColor,UIColor.white.cgColor]
      gradientLayer.startPoint = CGPoint(x: 0.0, y: 0.0)
      gradientLayer.endPoint = CGPoint(x: 0.7, y: 0.5)
      gradientLayer.frame = CGRect.zero
      return gradientLayer
    }()
    self.layer.addSublayer(gradientLayer)
    self.frame = self.bounds
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

extension UIImageView {
  func maskCircle(anyImage: UIImage) {
    self.image = anyImage
    self.contentMode = UIView.ContentMode.scaleAspectFill
    //self.layer.borderColor = UIColor.systemBlue.cgColor
    //self.layer.borderWidth = 1
    self.layer.cornerRadius = self.frame.height / 2
  }
  func shadow(anyImage: UIImage, anyView: UIView) {
    self.image = anyImage
    anyView.backgroundColor = nil
    anyView.layer.cornerRadius = anyView.frame.size.width / 2
    anyView.layer.shadowColor = UIColor.black.cgColor
    anyView.layer.shadowOffset = CGSize.zero
    anyView.layer.shadowRadius = 10
    anyView.layer.shadowOpacity = 0.9
    self.layer.cornerRadius = self.frame.size.width / 2
  }
}
