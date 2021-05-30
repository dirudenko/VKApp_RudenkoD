//
//  DetailedFriendCollectionViewCell.swift
//  VKapp_RudenkoD
//
//  Created by Dmitry on 11.04.2021.
//

import UIKit

class DetailedFriendCollectionViewCell: UICollectionViewCell {
  
  @IBOutlet weak var viewForShadow: UIView!
  @IBOutlet weak var avatarLabel: UIImageView!
  @IBOutlet weak var nameLabel: UILabel!
  @IBOutlet weak var ageLabel: UILabel!
  @IBOutlet weak var workLabel: UILabel!
  @IBOutlet weak var likeLabel: UILabel!
  @IBOutlet weak var likeButton: UIButton!
  private var isLiked = true
  var buttonPressed : (() -> ()) = {}
  
  func clearCell() {
    avatarLabel.image = nil
    nameLabel.text = nil
    ageLabel.text = nil
    workLabel.text = nil
  }
  
  override func prepareForReuse() {
    clearCell()
  }
  
  override func awakeFromNib() {
    super.awakeFromNib()
    clearCell()
    let tapRecognizer = UITapGestureRecognizer(target: self, action: #selector(animateAvatar(_:)))
    self.avatarLabel.addGestureRecognizer(tapRecognizer)
    self.avatarLabel.isUserInteractionEnabled = true
  }
  
  @IBAction func pressLikeButton(_ sender: Any) {
    pressLike(isLiked: &isLiked, likeCounter: likeLabel, likeButton: likeButton)
  }
  
  @IBAction func allPhotoButton(_ sender: Any) {
    buttonPressed()
  }
  
  @objc func animateAvatar(_ gestureRecognizer: UIGestureRecognizer) {
    avatarLabel.avatarAnimation()
  }
  
  func configure(name: String?, image: UIImage?, age: String?, work: String?) {
    if let image = image {
      avatarLabel.image = image
    }
    if let name = name {
      nameLabel.text = name
    }
    if let age = age {
      ageLabel.text = age
    }
    if let work = work {
      workLabel.text = work
    }
  }
}

extension DetailedFriendCollectionViewCell: UICollectionViewDelegateFlowLayout {
  func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
    return CGSize(width: 500.0, height: 500.0)
  }
}



