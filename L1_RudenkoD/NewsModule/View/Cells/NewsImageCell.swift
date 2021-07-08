//
//  NewsImageCell.swift
//  VKapp_RudenkoD
//
//  Created by Dmitry on 06.07.2021.
//

import UIKit

class NewsImageCell: UITableViewCell {
  
  @IBOutlet weak var newsImage: UIImageView!
  
  func clearCell() {
    newsImage.image = nil
  }
  
  override func prepareForReuse() {
    clearCell()
  }
  
  override func awakeFromNib() {
        super.awakeFromNib()
        clearCell()
    }
  func configure (image: UIImage?) {
    if let image = image {
      newsImage.image = image
    }
  }
}
