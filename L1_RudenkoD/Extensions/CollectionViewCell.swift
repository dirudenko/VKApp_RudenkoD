//
//  CollectionViewCell.swift
//  VKapp_RudenkoD
//
//  Created by Dmitry on 04.06.2021.
//

import UIKit
import SDWebImage

extension UICollectionViewCell {
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
}
