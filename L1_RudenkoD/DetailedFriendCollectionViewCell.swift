//
//  DetailedFriendCollectionViewCell.swift
//  VKapp_RudenkoD
//
//  Created by Dmitry on 11.04.2021.
//

import UIKit

class DetailedFriendCollectionViewCell: UICollectionViewCell {
 
  @IBOutlet weak var avatar: UIImageView!
  
  @IBOutlet weak var nameLabel: UILabel!
  
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }
  
  func configure(name: String, image: UIImage) {
//    avatar.image = image
    nameLabel.text = name
  }
}
