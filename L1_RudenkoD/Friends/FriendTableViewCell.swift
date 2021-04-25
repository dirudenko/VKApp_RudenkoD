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
    let tapRecognizer = UITapGestureRecognizer(target: self, action: #selector(animateAvatar(_:)))
    avatarImage.addGestureRecognizer(tapRecognizer)
    avatarImage.isUserInteractionEnabled = true
  }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
    }
  
  override func prepareForReuse() {
    clearCell()
  }
  
  @objc func animateAvatar(_ gestureRecognizer: UIGestureRecognizer) {
    avatarImage.avatarAnimation()
  }
  
  func configure(name: String?, image: UIImage?) {
    gradient()
    avatarImage.layer.zPosition = 1
    userName.layer.zPosition = 1
    if let image = image {
    avatarImage.image = image
      avatarImage.maskCircle(anyImage: image)
    }
    if let name = name {
    userName.text = name
    }
    
  }
}

