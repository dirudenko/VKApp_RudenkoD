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
    clearcell()
    let tapRecognizer = UITapGestureRecognizer(target: self, action: #selector(getFriend(_:)))
    self.stackView.addGestureRecognizer(tapRecognizer)
    self.stackView.isUserInteractionEnabled = true
  }
  
  override func prepareForReuse() {
    clearcell()
  }
  
  @objc func getFriend(_ gestureRecognizer: UIGestureRecognizer) {
    delegate?.namePressed(id: self.id)
  }
  
  func clearcell() {
    avatarImage.image = nil
    firstName.text = nil
    lastName.text = nil
  }
  
  func configure(name: String?, url: URL?, lName: String?) {
    if let url = url {
        self.avatarImage.setImage(at: url)
    }
    if let name = name {
      firstName.text = name
    }
    if let lName = lName {
      lastName.text = lName
    }
  }
}
