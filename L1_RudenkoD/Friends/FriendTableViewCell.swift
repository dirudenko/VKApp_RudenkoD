//
//  FriendTableViewCell.swift
//  VKapp_RudenkoD
//
//  Created by Dmitry on 11.04.2021.
//

import UIKit

class FriendTableViewCell: UITableViewCell {
  

  @IBOutlet weak var avatarImage: UIImageView!
  @IBOutlet weak var userName: UILabel!
  @IBOutlet weak var cellLabel: UIView!
  
  func clearCell() {
    avatarImage.image = nil
    userName.text = nil
  }
  
    override func awakeFromNib() {
        super.awakeFromNib()
        clearCell()
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
    }
  
  override func prepareForReuse() {
    clearCell()
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
    cellLabel.layer.addSublayer(gradientLayer)
    gradientLayer.frame = cellLabel.bounds
    avatarImage.layer.zPosition = 1
    userName.layer.zPosition = 1
  }
  
  func configure(name: String?, image: UIImage?) {
    gradient()
    if let image = image {
    avatarImage.image = image
      avatarImage.maskCircle(anyImage: image)
    }
    if let name = name {
    userName.text = name
    }
    
  }
}

//extension UIImageView {
//  public func maskCircle(anyImage: UIImage) {
//    self.contentMode = UIView.ContentMode.scaleAspectFill
//    self.layer.cornerRadius = self.frame.height / 2
//    self.layer.masksToBounds = false
//    self.clipsToBounds = true
//   self.image = anyImage
//  }
//}
//extension FriendTableViewCell: UICollectionViewDelegateFlowLayout {
//  func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
//    return CGSize(width: 400, height: 600)
//  }
//}
