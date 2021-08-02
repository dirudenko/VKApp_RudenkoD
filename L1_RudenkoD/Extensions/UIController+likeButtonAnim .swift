//
//  UIController+lokeButtonAnim .swift
//  VKapp_RudenkoD
//
//  Created by Dmitry on 29.05.2021.
//

import Foundation
import UIKit
import SDWebImage


extension UIViewController {
  func getImage(from string: String) -> UIImage? {
    var image: UIImage?
    guard let url = URL(string: string)
    else {
      print("Unable to create URL")
      return nil
    }
    
    do {
      let data = try Data(contentsOf: url, options: [])
      image = UIImage(data: data)
    }
    catch {
      print(error.localizedDescription)
    
    }
    
    return image
  }
  
  func asyncPhoto(cellImage: UIImageView, url: URL) -> UIImage {
    var asyncImage = UIImage()
    cellImage.sd_imageIndicator = SDWebImageActivityIndicator.gray
    cellImage.sd_setImage(with: url, placeholderImage: UIImage(named: "logo"),options: SDWebImageOptions(rawValue: 0), completed: { (image, error, cache, urls) in
                if (error != nil) {
                  asyncImage = UIImage(named: "logo") ?? UIImage()
                } else {
                  guard let image = image else { return }
                  asyncImage = image
                }
            })
    return asyncImage
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
