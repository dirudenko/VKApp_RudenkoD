//
//  GroupTableViewCell.swift
//  VKapp_RudenkoD
//
//  Created by Dmitry on 12.04.2021.
//

import UIKit

class GroupTableViewCell: UITableViewCell {

  @IBOutlet weak var groupAvatar: UIImageView!
  @IBOutlet weak var groupName: UILabel!
  @IBOutlet weak var groupDescription: UILabel!
  
  func clearCell() {
    groupAvatar.image = nil
    groupName.text = nil
    groupDescription.text = nil

  }
  
    override func awakeFromNib() {
        super.awakeFromNib()
        clearCell()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
  
  override func prepareForReuse() {
    clearCell()
  }
  
  func configure(name: String?, image: UIImage?, descr: String?) {
    if let image = image {
    groupAvatar.image = image
    }
    if let name = name {
    groupName.text = name
    }
    if let descr = descr {
    groupDescription.text = descr
    }
  }
}
    


