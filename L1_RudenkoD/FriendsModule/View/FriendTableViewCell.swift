//
//  FriendTableViewCell.swift
//  VKapp_RudenkoD
//
//  Created by Dmitry on 11.04.2021.
//

import UIKit

class FriendTableViewCell: UITableViewCell {
  
  @IBOutlet weak var viewForShadow: UIView!
  @IBOutlet weak var avatarImage: UIImageView!
  @IBOutlet weak var userName: UILabel!
  @IBOutlet weak var cellLabel: UIView!
    
  override func awakeFromNib() {
    super.awakeFromNib()
    clearCell()
  }

  override func prepareForReuse() {
    clearCell()
  }
  
  func configure(name: String?, url: URL?) {
    if let url = url {
        self.avatarImage.setImage(at: url)
    }
    
    if let name = name {
    userName.text = name
    }
  }
  
  func clearCell() {
    avatarImage.image = nil
    userName.text = nil
  }
}



