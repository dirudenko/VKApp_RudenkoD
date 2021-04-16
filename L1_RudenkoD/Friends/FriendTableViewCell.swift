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

        // Configure the view for the selected state
    }
  
  override func prepareForReuse() {
    clearCell()
  }
  
  func configure(name: String?, image: UIImage?) {
    if let image = image {
    avatarImage.image = image
    }
    if let name = name {
    userName.text = name
    }
  }
}

extension FriendTableViewCell: UICollectionViewDelegateFlowLayout {
  func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
    return CGSize(width: 400, height: 600)
  }
}
