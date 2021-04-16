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

//extension DetailedFriendCollectionViewCell: UICollectionViewDelegateFlowLayout {
//    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
//        return CGSize(width: 200.0, height: 200.0)
//    }
//}
