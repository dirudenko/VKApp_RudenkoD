//
//  NewsTextCell.swift
//  VKapp_RudenkoD
//
//  Created by Dmitry on 06.07.2021.
//

import UIKit

protocol NewsTextDelegate: AnyObject {
  func showMoreButtonPressed()
}

class NewsTextCell: UITableViewCell {
  
  @IBOutlet weak var newsText: UILabel!
  
  @IBOutlet weak var showButton: UIButton!
  weak var delegate: NewsTextDelegate?
  
  var isPressed: Bool = false {
    didSet {
      if isPressed == true {
      showButton.setTitle("Show less", for: .normal)
      } else {
        showButton.setTitle("Show more", for: .normal)
      }
    }
  }
  func clearCell() {
    
    newsText.text = nil
    showButton.alpha = 0
    showButton.isUserInteractionEnabled = false
  }
  
  override func prepareForReuse() {
    clearCell()
  }
  
  override func awakeFromNib() {
        super.awakeFromNib()
        clearCell()
    }
  
  @IBAction func pressButton(_ sender: Any) {
    isPressed = !isPressed
    if isPressed == true {
      newsText.numberOfLines = Int.max
    } else {
      newsText.numberOfLines = countLines(of: newsText, maxHeight: 200)
    }
    delegate?.showMoreButtonPressed()
  }
  
  func configure (text: String?) {
    if let text = text {
      newsText.text = text
      newsText.numberOfLines = countLines(of: newsText, maxHeight: 200)
      if newsText.numberOfLines == 11 {
      showButton.alpha = 1
      showButton.isUserInteractionEnabled = true
      }
    }
  }
  
  func countLines(of label: UILabel, maxHeight: CGFloat) -> Int {
          guard let labelText = label.text else { return 0 }
          let rect = CGSize(width: label.bounds.width, height: maxHeight)
          let labelSize = labelText.boundingRect(with: rect, options: .usesLineFragmentOrigin, attributes: [NSAttributedString.Key.font: label.font!], context: nil)
          let lines = Int(ceil(CGFloat(labelSize.height) / label.font.lineHeight))
          return labelText.contains("\n") && lines == 1 ? lines + 1 : lines
     }
  
}

