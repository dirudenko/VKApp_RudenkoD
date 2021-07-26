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
  @IBOutlet weak var groupMember: UIImageView!
  
  func clearCell() {
    groupAvatar.image = nil
    groupName.text = nil
    groupDescription.text = nil
    groupMember.image = nil
  }
  
  override func awakeFromNib() {
    super.awakeFromNib()
    clearCell()
    let tapRecognizer = UITapGestureRecognizer(target: self, action: #selector(animateAvatar(_:)))
    self.groupAvatar.addGestureRecognizer(tapRecognizer)
    self.groupAvatar.isUserInteractionEnabled = true
  }
  
  override func setSelected(_ selected: Bool, animated: Bool) {
    super.setSelected(selected, animated: animated)
  }
  
  @objc func animateAvatar(_ gestureRecognizer: UIGestureRecognizer) {
    groupAvatar.avatarAnimation()
  }
  
  override func prepareForReuse() {
    clearCell()
  }
  
  func configure(name: String?, url: URL?, descr: String?) {
    if let url = url {
      self.groupAvatar.setImage(at: url)
    }
    
    if let name = name {
      groupName.text = name
    }
    if let descr = descr {
      groupDescription.text = descr
    }
  }
}



