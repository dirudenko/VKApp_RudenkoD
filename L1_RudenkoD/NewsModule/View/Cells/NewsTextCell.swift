//
//  NewsTextCell.swift
//  VKapp_RudenkoD
//
//  Created by Dmitry on 06.07.2021.
//

import UIKit

class NewsTextCell: UITableViewCell {
  
  @IBOutlet weak var newsText: UILabel!
  
  func clearCell() {
    
    newsText.text = nil
  }
  
  override func prepareForReuse() {
    clearCell()
  }
  
  override func awakeFromNib() {
        super.awakeFromNib()
        clearCell()
    }
  
  func configure (text: String?) {
    if let text = text {
      newsText.text = text
    } 
  }
}
