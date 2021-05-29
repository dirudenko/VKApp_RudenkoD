//
//  UIImageView+ShadowCircleImage.swift
//  VKapp_RudenkoD
//
//  Created by Dmitry on 29.05.2021.
//

import Foundation
import UIKit

extension UIImageView {
  func maskCircle(anyImage: UIImage) {
    self.image = anyImage
    self.contentMode = UIView.ContentMode.scaleAspectFill
    //self.layer.borderColor = UIColor.systemBlue.cgColor
    //self.layer.borderWidth = 1
    self.layer.cornerRadius = self.frame.height / 2
  }
  
  func shadow(anyImage: UIImage, anyView: UIView, color: CGColor) {
    self.image = anyImage
    anyView.backgroundColor = nil
    anyView.layer.cornerRadius = anyView.frame.size.width / 2
    anyView.layer.shadowColor = color
    anyView.layer.shadowOffset = CGSize.zero
    anyView.layer.shadowRadius = 10
    anyView.layer.shadowOpacity = 0.9
    self.layer.cornerRadius = self.frame.size.width / 2
  }
}
