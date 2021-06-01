//
//  DetailedFriendCollectionViewController.swift
//  VKapp_RudenkoD
//
//  Created by Dmitry on 11.04.2021.
//

import UIKit

class DetailedFriendCollectionViewController: UICollectionViewController {
  
  @IBOutlet weak var photoAlbumButton: UIBarButtonItem!
  private let cellReuseIdentifier = "DetailedFriendCollectionViewCell"
  var friendId: Int?
  private var user = User()
  private let getUserRequest = ApiRequests()
  
  override func viewDidLoad() {
    super.viewDidLoad()
    
    let nibFile = UINib(nibName: cellReuseIdentifier, bundle: nil)
    self.collectionView.register(nibFile, forCellWithReuseIdentifier: cellReuseIdentifier)
  }
  
  override func viewWillAppear(_ animated: Bool) {
    super.viewWillAppear(animated)
    getUserRequest.getUserInfo(friendId: friendId!) {  [weak self] user in
      self?.user = user
      self?.title = String(user.id)
      self?.collectionView.reloadData()
    }
    
  }
  
  override func numberOfSections(in collectionView: UICollectionView) -> Int {
    return 1
  }
  
  override func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
    return 1
  }
  
  override func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
    guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: cellReuseIdentifier, for: indexPath) as? DetailedFriendCollectionViewCell else
    { return UICollectionViewCell() }
    let name = user.name
    var about = "сейчас"
    var avatar =  UIImage()
    let string = user.photo200
    if let image = getImage(from: string) {
      avatar = image
    }
    if user.online == 0 {
    about = user.lastOnline
      cell.avatarLabel.shadow(anyImage: avatar, anyView: cell.viewForShadow, color: UIColor.systemBlue.cgColor)
    } else {
      cell.avatarLabel.shadow(anyImage: avatar, anyView: cell.viewForShadow, color: UIColor.green.cgColor)
    }
    cell.configure(name: name, image: avatar, age: nil, work: about)
    cell.buttonPressed = { [weak self] in
      self?.performSegue(withIdentifier: "allPhotos", sender: UIButton())
    }
    return cell
  }
  
  override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
    if segue.identifier == "allPhotos" {
      let controller = segue.destination as! PhotosCollectionViewController
      controller.friendId = friendId
    }
  }
}

