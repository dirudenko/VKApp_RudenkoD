//
//  DetailedFriendCollectionViewCell.swift
//  VKapp_RudenkoD
//
//  Created by Dmitry on 11.04.2021.
//

import UIKit

class DetailedFriendCollectionViewCell: UICollectionViewCell {
  
  @IBOutlet weak var avatarLabel: UIImageView!
  @IBOutlet weak var nameLabel: UILabel!
  @IBOutlet weak var ageLabel: UILabel!
  @IBOutlet weak var workLabel: UILabel!
  @IBOutlet weak var likeLabel: UILabel!
  @IBOutlet weak var likeButton: UIButton!
  var isLiked = true
  var isPressed = false
  
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
    isPressed = !isPressed
  }
  
  func configure(name: String?, image: UIImage?, age: String?, work: String?) {
    if let image = image {
      avatarLabel.image = image
//      avatarLabel.clipsToBounds = true
//      avatarLabel.layer.cornerRadius = avatarLabel.frame.height / 2
//      avatarLabel.addShadow(offset: CGSize.init(width: 0, height: 3), color: UIColor.black, radius: 2.0, opacity: 0.35)
      
//      avatarLabel.contentMode = UIView.ContentMode.scaleAspectFill
      //avatarLabel.layer.cornerRadius = avatarLabel.frame.height / 2
//      avatarLabel.clipsToBounds = true
//
//      avatarLabel.layer.shadowColor = UIColor.black.cgColor
//      avatarLabel.layer.shadowOffset = CGSize(width: 15.0, height: 15.0)
//      avatarLabel.layer.shadowRadius = 20
//      avatarLabel.layer.shadowOpacity = 0.9
//      avatarLabel.layer.masksToBounds = true
//      avatarLabel.clipsToBounds = false
//      addSubview(avatarLabel)
      
      //avatarLabel.maskCircle(anyImage: image)
      //avatarLabel.shadow(anyImage: image)
      //avatarLabel.layer.masksToBounds = false;
      //      let outerView = UIView(frame: CGRect(x: 0, y: 0, width: 100, height: 100))
      //      outerView.clipsToBounds = false
      //      outerView.layer.shadowColor = UIColor.black.cgColor
      //      outerView.layer.shadowOpacity = 1
      //      outerView.layer.shadowOffset = CGSize.zero
      //      outerView.layer.shadowRadius = 10
      //      outerView.layer.shadowPath = UIBezierPath(roundedRect: outerView.bounds, cornerRadius: 10).cgPath
      //      let myImage = UIImageView(frame: outerView.bounds)
      //      avatarLabel.clipsToBounds = true
      //      avatarLabel.layer.cornerRadius = 10
      //      outerView.addSubview(avatarLabel)
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
    self.layer.borderColor = UIColor.systemBlue.cgColor
    self.layer.borderWidth = 1
    self.layer.cornerRadius = self.frame.height / 2
    //self.layer.masksToBounds = true
    //addSubview()
  }
  public func shadow(anyImage: UIImage) {
    //self.image = anyImage
    //self.contentMode = UIView.ContentMode.scaleAspectFill
    
    self.layer.shadowColor = UIColor.black.cgColor
    self.layer.shadowOffset = CGSize(width: 15.0, height: 15.0)
    self.layer.shadowRadius = 2
    self.layer.shadowOpacity = 0.9
    self.layer.masksToBounds = true
    //self.layer.cornerRadius = self.frame.height / 2
    self.clipsToBounds = false
    //addSubview(self)
  }
}
extension UIView {
  func addShadow(offset: CGSize, color: UIColor, radius: CGFloat, opacity: Float) {
          layer.masksToBounds = false
          layer.shadowOffset = offset
          layer.shadowColor = color.cgColor
          layer.shadowRadius = radius
          layer.shadowOpacity = opacity

          let backgroundCGColor = backgroundColor?.cgColor
          backgroundColor = nil
          layer.backgroundColor =  backgroundCGColor
      }
}

