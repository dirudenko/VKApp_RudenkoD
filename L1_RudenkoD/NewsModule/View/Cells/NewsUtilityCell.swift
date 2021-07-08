//
//  NewsUtilityCell.swift
//  VKapp_RudenkoD
//
//  Created by Dmitry on 06.07.2021.
//

import UIKit

protocol NewsButtonsDelegate: AnyObject {
  func share()
}

class NewsUtilityCell: UITableViewCell {
  
  @IBOutlet weak var likeCounter: UILabel!
  
  @IBOutlet weak var shareCounter: UILabel!
  
  @IBOutlet weak var commentCounter: UILabel!
  
  @IBOutlet weak var likeButton: UIButton!
  @IBOutlet weak var viewCounter: UILabel!
  private var isLiked = true
  weak var delegate: NewsButtonsDelegate?
  
  func clearCell() {
    
    likeCounter.text = nil
    shareCounter.text = nil
    commentCounter.text = nil
    viewCounter.text = nil
  }
  
  override func prepareForReuse() {
    clearCell()
  }
  
  override func awakeFromNib() {
        super.awakeFromNib()
        clearCell()
    }
  
  @IBAction func pressLikeButton(_ sender: Any) {
    pressLike(isLiked: &isLiked, likeCounter: likeCounter, likeButton: likeButton)
  }
  
  @IBAction func pressShareButton(_ sender: Any) {
    delegate?.share()
  }
  
  func configure (likes: String?, shared: String?, view: String?, comments: String?) {
    if let likes = likes {
      likeCounter.text = likes
    }
    if let shared = shared {
      shareCounter.text = shared
    }
    if let view = view {
      viewCounter.text = view
    }
    if let comments = comments {
      commentCounter.text = comments
    }
  }
  
}
