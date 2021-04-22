//
//  NewsTableViewCell.swift
//  VKapp_RudenkoD
//
//  Created by Dmitry on 22.04.2021.
//

import UIKit

protocol NewsButtonsDelegate: class {
  func share()
  func namePressed(button: UIButton)
}


class NewsTableViewCell: UITableViewCell {

  @IBOutlet weak var userImage: UIImageView!
  @IBOutlet weak var userViewImage: UIView!
  @IBOutlet weak var userName: UIButton!
  @IBOutlet weak var postedDate: UILabel!
  @IBOutlet weak var postedNews: UILabel!
  @IBOutlet weak var imageForNews1: UIImageView!
  @IBOutlet weak var imageForNews2: UIImageView!
  @IBOutlet weak var likeButton: UIButton!
  @IBOutlet weak var likeCounter: UILabel!
  @IBOutlet weak var commentCounter: UILabel!
  @IBOutlet weak var commentButton: UIButton!
  @IBOutlet weak var sharedCounter: UILabel!
  @IBOutlet weak var sharedButton: UIButton!
  @IBOutlet weak var constraintHeight1: NSLayoutConstraint!
  @IBOutlet weak var constraintHeight2: NSLayoutConstraint!
  @IBOutlet weak var viewForShadow: UIView!
  var isLiked = true
  weak var delegate: NewsButtonsDelegate?
  
  func clearCell() {
    userImage.image = nil
    userViewImage = nil
    userName.setTitle(nil, for: .normal)
    postedDate.text = nil
    postedNews.text = nil
    imageForNews1.image = nil
    imageForNews2.image = nil
    likeCounter.text = nil
    constraintHeight1.constant = 0
    //commentCounter.text = nil
    //sharedCounter.text = nil
  }
  
  override func prepareForReuse() {
    clearCell()
  }
  
  override func awakeFromNib() {
        super.awakeFromNib()
        clearCell()
//    userName.isUserInteractionEnabled = true
//    let gestureRecognizer = UITapGestureRecognizer(target: self, action: Selector("pressShareButton"))
//    let labelTap = UITapGestureRecognizer(target: self, action: #selector(self.namePressed(_:)))
//    userName.addGestureRecognizer(labelTap)
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
  
  
  @IBAction func pressShareButton(_ sender: Any) {
    delegate?.share()
  }
  
  @IBAction func pressNameButton(_ sender: Any) {
    guard let button = userName else { return }
    delegate?.namePressed(button: button)
  }
  
  
  @IBAction func pressLikeButton(_ sender: Any) {
    if isLiked {
      likeCounter.text = "\(Int(likeCounter.text!)! + 1)"
      likeButton.setImage(UIImage(systemName: "heart.fill"), for: .normal)
      likeButton.tintColor = UIColor.systemRed
    }
    else {
      likeCounter.text = "\(Int(likeCounter.text!)! - 1)"
      likeButton.setImage(UIImage(systemName: "heart"), for: .normal)
      likeButton.tintColor = UIColor.systemBlue
    }
    isLiked = !isLiked

  }
  
  
  func configure (image: UIImage?, name: String?, posted: String?, newNews: String?, imageNews1: UIImage?, imageNews2: UIImage?, shared: String?){
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
    if let newNews = newNews {
      postedNews.text = newNews
    }
    if let imageNews1 = imageNews1 {
      imageForNews1.image = imageNews1
      if imageForNews1.image != nil {
      let ratio = imageNews1.size.width / imageNews1.size.height
      let newHeight = imageForNews1.frame.width / ratio
      constraintHeight1.constant = newHeight
      }
    }
    if let imageNews2 = imageNews2 {
      imageForNews2.image = imageNews2
      if imageForNews2.image != nil {
      let ratio = imageNews2.size.width / imageNews2.size.height
      let newHeight = imageForNews2.frame.width / ratio
      constraintHeight2.constant = newHeight
      }
    }
    if let shared = shared {
      sharedCounter.text = shared
    }
  }
  
    
}
