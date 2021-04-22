//
//  NewsTableViewCell.swift
//  VKapp_RudenkoD
//
//  Created by Dmitry on 22.04.2021.
//

import UIKit

protocol NewsButtonsDelegate: class {
  func share()
}


class NewsTableViewCell: UITableViewCell {

  
  
  @IBOutlet weak var userImage: UIImageView!
  @IBOutlet weak var userViewImage: UIView!
  @IBOutlet weak var userName: UILabel!
  @IBOutlet weak var postedDate: UILabel!
  @IBOutlet weak var postedNews: UILabel!
  @IBOutlet weak var imageForNews: UIImageView!
  @IBOutlet weak var likeButton: UIButton!
  @IBOutlet weak var likeCounter: UILabel!
  @IBOutlet weak var commentCounter: UILabel!
  @IBOutlet weak var commentButton: UIButton!
  @IBOutlet weak var sharedCounter: UILabel!
  @IBOutlet weak var sharedButton: UIButton!
  @IBOutlet weak var constraintHeight: NSLayoutConstraint!
  
  var isLiked = true
  weak var delegate: NewsButtonsDelegate?
  
  func clearCell() {
    userImage.image = nil
    userViewImage = nil
    userName.text = nil
    postedDate.text = nil
    postedNews.text = nil
    imageForNews.image = nil
    likeCounter.text = nil
    //commentCounter.text = nil
    //sharedCounter.text = nil
  }
  
  override func prepareForReuse() {
    clearCell()
  }
  
  override func awakeFromNib() {
        super.awakeFromNib()
        clearCell()
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
  
  
  @IBAction func pressShareButton(_ sender: Any) {
    delegate?.share()
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
  
  
  func configure (image: UIImage?, name: String?, posted: String?, newNews: String?, imageNews: UIImage?){
    if let image = image {
      userImage.image = image
    }
    if let name = name {
      userName.text = name
    }
    if let posted = posted {
      postedDate.text = posted
    }
    if let newNews = newNews {
      postedNews.text = newNews
    }
    if let imageNews = imageNews {
      imageForNews.image = imageNews
      if imageForNews.image != nil {
      let ratio = imageNews.size.width / imageNews.size.height
      let newHeight = imageForNews.frame.width / ratio
      constraintHeight.constant = newHeight
      }
    }
  }
  
    
}
