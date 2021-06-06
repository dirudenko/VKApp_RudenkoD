//
//  PhotosCollectionViewCell.swift
//  VKapp_RudenkoD
//
//  Created by Dmitry on 19.04.2021.
//

import UIKit

class PhotosCollectionViewCell: UICollectionViewCell {
  
  @IBOutlet weak var viewForPhoto: UIView!
  @IBOutlet weak var photoView: UIImageView!
  @IBOutlet weak var likeButton: UIButton!
  @IBOutlet weak var likeLabel: UILabel!
  private var isLiked = true
  
  override func awakeFromNib() {
    super.awakeFromNib()
    clearCell()
  }
  
  override func prepareForReuse() {
    clearCell()
  }
  
  @IBAction func pressLikeButton(_ sender: Any) {
    pressLike(isLiked: &isLiked, likeCounter: likeLabel, likeButton: likeButton)
  }
  
  func configure( image: UIImage?) {
    if let image = image {
      photoView.image = image
    }
  }
  
  func clearCell() {
    photoView.image = nil
  }
}


