//
//  NewsTableViewCell.swift
//  VKapp_RudenkoD
//
//  Created by Dmitry on 22.04.2021.
//

import UIKit

//protocol NewsButtonsDelegate: AnyObject {
//  func share()
//}


class NewsTableViewCell: UITableViewCell {

  @IBOutlet weak var userImage: UIImageView!
  @IBOutlet weak var userViewImage: UIView!
  @IBOutlet weak var userName: UIButton!
  @IBOutlet weak var postedDate: UILabel!
  @IBOutlet weak var postedNews: UILabel!
  @IBOutlet weak var imageForNews: UIImageView!
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
    imageForNews.image = nil
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
        clearCell()
    }

  @IBAction func pressShareButton(_ sender: Any) {
    //delegate?.share()
  }
  
  
  @IBAction func pressLikeButton(_ sender: Any) {
    pressLike(isLiked: &isLiked, likeCounter: likeCounter, likeButton: likeButton)
 }
  
  func configure (image: UIImage?, name: String?, posted: String?, newNews: String?, imageNews: UIImage?, shared: String?, view: String?, comments: String?) {
    if let image = image {
      userImage.image = image
    }
    if let name = name {
      userName.setTitle(name, for: .normal)
      userName.setTitleColor(.systemBlue, for: .selected)
    }
    if let imageNews = imageNews {
      imageForNews.image = imageNews
      if imageForNews.image != nil {
      //let ratio = imageNews.size.width / imageNews.size.height
      //let newHeight = imageForNews.frame.width / ratio
      constraintHeight1.constant = 300
      } else {
        constraintHeight1.constant = 0
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
