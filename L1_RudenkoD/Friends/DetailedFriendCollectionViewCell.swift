//
//  DetailedFriendCollectionViewCell.swift
//  VKapp_RudenkoD
//
//  Created by Dmitry on 11.04.2021.
//

import UIKit



class DetailedFriendCollectionViewCell: UICollectionViewCell {
  
  @IBOutlet weak var viewForShadow: UIView!
  @IBOutlet weak var avatarLabel: UIImageView!
  @IBOutlet weak var nameLabel: UILabel!
  @IBOutlet weak var aboutLabel: UILabel!
  @IBOutlet weak var lastOnlineLabel: UILabel!
  @IBOutlet weak var collectionView: UICollectionView!
  //var friendId: Int?
  weak var delegate: DetailedFriendDelegate?
  
  var id = Session.shared.userId
    
  
  var buttonPressed : (() -> ()) = {}
  private let cellReuseIdentifier = "FriendsCollectionViewCell"
  private let getUserRequest = ApiRequests()
  private var userFriends = [Users]()
  
  func clearCell() {
    avatarLabel.image = nil
    nameLabel.text = nil
    aboutLabel.text = nil
    lastOnlineLabel.text = nil
  }
  
  override func prepareForReuse() {
    clearCell()
  }
  
  override func awakeFromNib() {
    super.awakeFromNib()
    
    getUserRequest.getFriendList(userId: id) {  [weak self] users in
      self?.userFriends = users
      self?.collectionView.reloadData()
    }
    self.collectionView.dataSource = self
    self.collectionView.delegate = self
    let nibFile = UINib(nibName: cellReuseIdentifier, bundle: nil)
    self.collectionView.register(nibFile, forCellWithReuseIdentifier: cellReuseIdentifier)
    //clearCell()
    let tapRecognizer = UITapGestureRecognizer(target: self, action: #selector(animateAvatar(_:)))
    self.avatarLabel.addGestureRecognizer(tapRecognizer)
    self.avatarLabel.isUserInteractionEnabled = true
    
  
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
    cell.firstName.text = userFriends[indexPath.row].firstName
    cell.lastName.text = userFriends[indexPath.row].lastName
    var avatar =  UIImage()
    let string = userFriends[indexPath.row].photo50
    if let image = getImage(from: string) {
      avatar = image
    }
    cell.avatarImage.shadow(anyImage: avatar, anyView: cell.viewForShadow, color: UIColor.systemBlue.cgColor)
    cell.id = userFriends[indexPath.row].id
    cell.delegate = self
    return cell
  }
}

extension DetailedFriendCollectionViewCell: DetailedFriendDelegate {
  func namePressed(id: Int) {
    //DetailedFriendCollectionViewController().namePressed(id: id)
  }
}




