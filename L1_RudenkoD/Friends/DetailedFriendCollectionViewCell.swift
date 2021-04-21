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
  var isLiked = true
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
  
  @IBAction func allPhotoButton(_ sender: Any) {
    buttonPressed()
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

extension UIImageView {
  public func maskCircle(anyImage: UIImage) {
    self.image = anyImage
    self.contentMode = UIView.ContentMode.scaleAspectFill
    //self.layer.borderColor = UIColor.systemBlue.cgColor
    //self.layer.borderWidth = 1
    self.layer.cornerRadius = self.frame.height / 2
  }
  public func shadow(anyImage: UIImage, anyView: UIView) {
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


