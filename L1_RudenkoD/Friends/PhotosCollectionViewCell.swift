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
  private var isClickedPhoto = false
  
  func clearCell() {
    photoView.image = nil
  }
  
  override func awakeFromNib() {
    super.awakeFromNib()
    clearCell()
    let tapRecognizer = UITapGestureRecognizer(target: self, action: #selector(animateAvatar(_:)))
    photoView.addGestureRecognizer(tapRecognizer)
    photoView.isUserInteractionEnabled = true
    viewForPhoto.addGestureRecognizer(tapRecognizer)
    viewForPhoto.isUserInteractionEnabled = true
    // Initialization code
  }
  
  @IBAction func pressLikeButton(_ sender: Any) {
    pressLike(isLiked: &isLiked, likeCounter: likeLabel, likeButton: likeButton)
  }
  
  @objc func animateAvatar(_ gestureRecognizer: UIGestureRecognizer) {
    photoAppereance(photoView: photoView, isClickedPhoto: &isClickedPhoto)
    //isClickedPhoto = !isClickedPhoto
  }
  
  func configure( image: UIImage?) {
    if let image = image {
      photoView.image = image
      photoView.transform = CGAffineTransform(scaleX: 0.1, y: 0.1)
      photoView.alpha = 0
      var tmp = !isClickedPhoto
      photoAppereance(photoView: photoView, isClickedPhoto: &tmp)
//      photoView.layer.borderColor = UIColor.systemBlue.cgColor
//      photoView.layer.borderWidth = 1
    }
  }
}
