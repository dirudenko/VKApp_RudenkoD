//
//  NewsSourceCell.swift
//  VKapp_RudenkoD
//
//  Created by Dmitry on 06.07.2021.
//

import UIKit

class NewsSourceCell: UITableViewCell {
  @IBOutlet weak var userImage: UIImageView!
  @IBOutlet weak var viewForShadow: UIView!
  @IBOutlet weak var userName: UIButton!
  @IBOutlet weak var postedDate: UILabel!
 
  func clearCell() {
    userImage.image = nil
    viewForShadow = nil
    userName.setTitle(nil, for: .normal)
    postedDate.text = nil
  }
  
  override func prepareForReuse() {
    clearCell()
  }
  
  override func awakeFromNib() {
        super.awakeFromNib()
        clearCell()
    }
  
  func configure (image: UIImage?, name: String?, posted: String?) {
    if let image = image {
      userImage.image = image
    }
    if let name = name {
      userName.setTitle(name, for: .normal)
      userName.setTitleColor(.systemBlue, for: .selected)
    }
    if let posted = posted {
      postedDate.text = posted.description
    }
  }
  
}
