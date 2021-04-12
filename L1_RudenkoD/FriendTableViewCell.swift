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
  
  
 

  //let nibIdentifier = "FriendTableViewCell"
  //let nibFile = UINib(nibName: nibIdentifier, bundle: nil)
   
  func clearCell(){
    avatarImage = nil
    userName = nil
  }
  
    override func awakeFromNib() {
        super.awakeFromNib()
        //clearCell()
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
  
  override func prepareForReuse() {
    //clearCell()
  }
  
  func configure(name: String, age: String, image: UIImage) {
    avatarImage.image = image
    userName.text = name
  }
  
}
