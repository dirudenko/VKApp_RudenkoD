//
//  CharPeekerControl.swift
//  VKapp_RudenkoD
//
//  Created by Dmitry on 20.04.2021.
//

import UIKit
protocol NameDelegate: AnyObject {
  func didPressButton(button: UIButton)
}


@IBDesignable class CharPeekerControl: UIControl {
  var selectedChar: String? = nil
  private var buttons: [UIButton] = []
  private var stackView: UIStackView!
  var isPressed = true
  weak var delegate: NameDelegate!
  
  private func setupView() {
    let char = findChars()
    for item in char {
      let button = UIButton(type: .system)
      button.setTitle(item, for: .normal)
      button.setTitleColor(.systemBlue, for: .normal)
      button.setTitleColor(.white, for: .selected)
      button.addTarget(self, action: #selector(selectFriend(_:)), for:.touchUpInside)
      self.buttons.append(button)
    }
    stackView = UIStackView(arrangedSubviews: self.buttons)
    self.addSubview(stackView)
    stackView.spacing = 0
    stackView.axis = .vertical
    stackView.alignment = .leading
    stackView.distribution = .fillEqually
  }
  
  override func layoutSubviews() {
    super.layoutSubviews()
    stackView.frame = bounds
  }
  
  override init(frame: CGRect) {
    super.init(frame: frame)
    self.setupView()
    
  }
  required init?(coder aDecoder: NSCoder) { super.init(coder: aDecoder)
    self.setupView()
  }
  
  
  func findChars() -> [String] {
    var unsortedChars = Set<String>()
    for item in DataStorage.shared.usersArray {
      let char = item.name.first
      unsortedChars.insert(String(char!))
    }
    let sortedChars = Array(unsortedChars.sorted())
    //DataStorage.shared.sortedChars = sortedChars
    return Array(sortedChars)
  }
  
  @objc private func selectFriend(_ sender: UIButton) {
    guard let index = self.buttons.firstIndex(of: sender)
    else { return }
    let button = self.buttons[index]
   // DataStorage.shared.charIndex = Int(index)
    delegate?.didPressButton(button: button)
  }
}
