//
//  PhotosCollectionViewCell.swift
//  VKapp_RudenkoD
//
//  Created by Dmitry on 19.04.2021.
//

import UIKit

class PhotosCollectionViewCell: UICollectionViewCell {
  
  @IBOutlet weak var photoView: UIImageView!
  @IBOutlet weak var likeButton: UIButton!
  @IBOutlet weak var likeLabel: UILabel!
  var isLiked = true
  
  func clearCell() {
    photoView.image = nil
  }
  
  override func awakeFromNib() {
    super.awakeFromNib()
    clearCell()
    // Initialization code
  }
  
  @IBAction func pressLikeButton(_ sender: Any) {
    if isLiked {
      likeLabel.text = "1"
      likeButton.setImage(UIImage(systemName: "heart.fill"), for: .normal)
      likeButton.tintColor = UIColor.systemRed
    }
    else {
      likeLabel.text = "0"
      likeButton.setImage(UIImage(systemName: "heart"), for: .normal)
      likeButton.tintColor = UIColor.systemBlue
    }
    isLiked = !isLiked
  }
  
  func configure( image: UIImage?) {
    if let image = image {
      photoView.image = image
      photoView.layer.borderColor = UIColor.systemBlue.cgColor
      photoView.layer.borderWidth = 1
    }
  }
}
