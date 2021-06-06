//
//  DetailedFriendCollectionViewCell.swift
//  VKapp_RudenkoD
//
//  Created by Dmitry on 11.04.2021.
//

import UIKit

protocol DetailedViewDelegate: AnyObject {
  func goVC(id: Int)
}

class DetailedFriendCollectionViewCell: UICollectionViewCell {
  
  @IBOutlet weak var viewForShadow: UIView!
  @IBOutlet weak var avatarLabel: UIImageView!
  @IBOutlet weak var nameLabel: UILabel!
  @IBOutlet weak var aboutLabel: UILabel!
  @IBOutlet weak var lastOnlineLabel: UILabel!
  @IBOutlet weak var collectionView: UICollectionView!
  @IBOutlet weak var friendsCount: UILabel!
  
  weak var delegate: DetailedFriendDelegate?
  weak var cellDelegate: DetailedViewDelegate?
  var id = Session.shared.userId.last
    
  
  var buttonPressed : (() -> ()) = {}
  private let cellReuseIdentifier = "FriendsCollectionViewCell"
  private let getUserRequest = APIService()
  private var userFriends = [Users]()
  
  func clearCell() {
    avatarLabel.image = nil
    nameLabel.text = nil
    aboutLabel.text = nil
    lastOnlineLabel.text = nil
    friendsCount.text = nil
  }
  
  override func prepareForReuse() {
    clearCell()
  }
  
  override func awakeFromNib() {
    super.awakeFromNib()
    getUserRequest.getFriendList(userId: id) {  [weak self] users in
      self?.userFriends = users
      self?.friendsCount.text = String(self?.userFriends.count ?? 0)
      self?.collectionView.reloadData()
    }
    collectionView.dataSource = self
    collectionView.delegate = self
    let nibFile = UINib(nibName: cellReuseIdentifier, bundle: nil)
    collectionView.register(nibFile, forCellWithReuseIdentifier: cellReuseIdentifier)
    let tapRecognizer = UITapGestureRecognizer(target: self, action: #selector(animateAvatar(_:)))
    avatarLabel.addGestureRecognizer(tapRecognizer)
    avatarLabel.isUserInteractionEnabled = true
    clearCell()
  }
  
  @IBAction func allPhotoButton(_ sender: Any) {
    buttonPressed()
  }
  
  @objc func animateAvatar(_ gestureRecognizer: UIGestureRecognizer) {
    avatarLabel.avatarAnimation()
  }
  
  func configure(name: String?, image: UIImage?, about: String?, online: String?) {
    if let image = image {
      avatarLabel.image = image
    }
    if let name = name {
      nameLabel.text = name
    }
    if let about = about {
      aboutLabel.text = about
    }
    if let online = online {
      lastOnlineLabel.text = online
    }
  }
}

extension DetailedFriendCollectionViewCell: UICollectionViewDelegate, UICollectionViewDataSource {
  
  func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
    return userFriends.count
  }
  func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
    let cell = collectionView.dequeueReusableCell(withReuseIdentifier: cellReuseIdentifier, for: indexPath as IndexPath) as! FriendsCollectionViewCell
    let name = userFriends[indexPath.row].firstName
    let lName = userFriends[indexPath.row].lastName
    let string = URL(string: userFriends[indexPath.row].photo50)!
    let avatar = asyncPhoto(cellImage: cell.avatarImage, url: string)
    cell.avatarImage.shadow(anyImage: avatar, anyView: cell.viewForShadow, color: UIColor.systemBlue.cgColor)
    cell.id = userFriends[indexPath.row].id
    cell.configure(name: name, image: avatar, lName: lName)
    cell.delegate = self
    return cell
  }
}

extension DetailedFriendCollectionViewCell: DetailedFriendDelegate {
  func namePressed(id: Int) {
    cellDelegate?.goVC(id: id)
  }
}




