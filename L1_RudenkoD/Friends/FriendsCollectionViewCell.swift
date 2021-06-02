//
//  FriendsCollectionViewCell.swift
//  VKapp_RudenkoD
//
//  Created by Dmitry on 02.06.2021.
//

import UIKit

protocol DetailedFriendDelegate: AnyObject {
  func namePressed(id: Int)
}

class FriendsCollectionViewCell: UICollectionViewCell {
  
  @IBOutlet weak var firstName: UILabel!
  @IBOutlet weak var lastName: UILabel!
  @IBOutlet weak var avatarImage: UIImageView!
  @IBOutlet weak var stackView: UIStackView!
  @IBOutlet weak var viewForShadow: UIView!
  weak var delegate: DetailedFriendDelegate?
  var id = Int()
  
  override func awakeFromNib() {
    super.awakeFromNib()
    
    let tapRecognizer = UITapGestureRecognizer(target: self, action: #selector(getFriend(_:)))
    self.stackView.addGestureRecognizer(tapRecognizer)
    self.stackView.isUserInteractionEnabled = true
    
  }
  
  
  @objc func getFriend(_ gestureRecognizer: UIGestureRecognizer) {
   // self.id = Session.shared.userId
   // print(self.id)
    delegate?.namePressed(id: self.id)
  }
}
