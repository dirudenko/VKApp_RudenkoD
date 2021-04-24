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
  @IBOutlet weak var likeButton: UIButton!
  @IBOutlet weak var likeCounter: UILabel!
  @IBOutlet weak var commentCounter: UILabel!
  @IBOutlet weak var commentButton: UIButton!
  @IBOutlet weak var sharedCounter: UILabel!
  @IBOutlet weak var sharedButton: UIButton!
  @IBOutlet weak var constraintHeight1: NSLayoutConstraint!
  @IBOutlet weak var viewForShadow: UIView!
  @IBOutlet weak var viewCounter: UILabel!
  private var isLiked = true
  weak var delegate: NewsButtonsDelegate?
  
  func clearCell() {
    userImage.image = nil
    userViewImage = nil
    userName.setTitle(nil, for: .normal)
    postedDate.text = nil
    postedNews.text = nil
    imageForNews1.image = nil
    likeCounter.text = nil
    constraintHeight1.constant = 0
    viewCounter.text = nil
    sharedCounter.text = nil
    commentCounter.text = nil
  }
  
  override func prepareForReuse() {
    clearCell()
  }
  
  override func awakeFromNib() {
        super.awakeFromNib()
    let tapRecognizer = UITapGestureRecognizer(target: self, action: #selector(animateAvatar(_:)))
    self.userImage.addGestureRecognizer(tapRecognizer)
    self.userImage.isUserInteractionEnabled = true
        clearCell()
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
    
    pressLike(isLiked: &isLiked, likeCounter: likeCounter, likeButton: likeButton)
 }
  
  @objc func animateAvatar(_ gestureRecognizer: UIGestureRecognizer) {
    userImage.avatarAnimation()
  }
  
  func configure (image: UIImage?, name: String?, posted: String?, newNews: String?, imageNews1: UIImage?, shared: String?, view: String?, comments: String?) {
    if let image = image {
      userImage.image = image
    }
    if let name = name {
      userName.setTitle(name, for: .normal)
      userName.setTitleColor(.systemBlue, for: .selected)
    }
    if let imageNews1 = imageNews1 {
      imageForNews1.image = imageNews1
      if imageForNews1.image != nil {
      let ratio = imageNews1.size.width / imageNews1.size.height
      let newHeight = imageForNews1.frame.width / ratio
      constraintHeight1.constant = newHeight
      }
    }
    
    if let posted = posted {
      postedDate.text = posted.description
    }
    if let newNews = newNews {
      postedNews.text = newNews
    }
    
    if let shared = shared {
      sharedCounter.text = shared
    }
    if let view = view {
      viewCounter.text = view
    }
    if let comments = comments {
      commentCounter.text = comments
    }
  }
}
