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
  @IBOutlet weak var cellLabel: UIView!
  
  func clearCell() {
    avatarImage.image = nil
    userName.text = nil
  }
  
  override func awakeFromNib() {
    super.awakeFromNib()
    clearCell()
    let tapRecognizer = UITapGestureRecognizer(target: self, action: #selector(animateAvatar(_:)))
    self.avatarImage.addGestureRecognizer(tapRecognizer)
    self.avatarImage.isUserInteractionEnabled = true
  }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
    }
  
  override func prepareForReuse() {
    clearCell()
  }
  
  @objc func animateAvatar(_ gestureRecognizer: UIGestureRecognizer) {
    avatarImage.transform = CGAffineTransform(scaleX: 0.1, y: 0.1)
    UIView.animate(withDuration: 0.5,
                   delay: 0,
                   options: .curveEaseOut,
                   animations: { [weak self] in
                    self?.avatarImage.transform = .identity
                   },
                   completion: nil)
  }
  
  func gradient() {
    let gradientLayer: CAGradientLayer = {
        let gradientLayer = CAGradientLayer()
      gradientLayer.colors = [UIColor.lightGray.cgColor,UIColor.white.cgColor]
      gradientLayer.startPoint = CGPoint(x: 0.0, y: 0.0)
      gradientLayer.endPoint = CGPoint(x: 0.7, y: 0.5)
        gradientLayer.frame = CGRect.zero
       return gradientLayer
    }()
    cellLabel.layer.addSublayer(gradientLayer)
    gradientLayer.frame = cellLabel.bounds
    avatarImage.layer.zPosition = 1
    userName.layer.zPosition = 1
  }
  
  func configure(name: String?, image: UIImage?) {
    gradient()
    if let image = image {
    avatarImage.image = image
      avatarImage.maskCircle(anyImage: image)
    }
    if let name = name {
    userName.text = name
    }
    
  }
}

