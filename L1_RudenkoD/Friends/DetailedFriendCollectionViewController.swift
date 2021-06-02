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
  
  private var user = User()
  private let getUserRequest = ApiRequests()
  private var userFriends = [Users]()
  
  
  override func viewDidLoad() {
    super.viewDidLoad()
    
    let nibFile = UINib(nibName: cellReuseIdentifier, bundle: nil)
    self.collectionView.register(nibFile, forCellWithReuseIdentifier: cellReuseIdentifier)
    
  }
  
  override func viewWillAppear(_ animated: Bool) {
    super.viewWillAppear(animated)
    let id = Session.shared.userId
    getUserRequest.getUserInfo(friendId: id) {  [weak self] user in
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
    return prepareCell(cell: cell)
  }
  
  override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
    if segue.identifier == "allPhotos" {
      let controller = segue.destination as! PhotosCollectionViewController
     // controller.friendId = id
    }
  }
}

extension DetailedFriendCollectionViewController {
  func prepareCell(cell: DetailedFriendCollectionViewCell) -> DetailedFriendCollectionViewCell {
    
//    var id = Session.shared.userId {
//      didSet {
//        performSegue(withIdentifier: "FriendInfo", sender: (Any).self)
//      }
//    }
    
    let name = user.name
    var online = "сейчас"
    var avatar =  UIImage()
    let string = user.photo200
    if let image = getImage(from: string) {
      avatar = image
    }
    if user.online == 0 {
      online = user.lastOnline
      cell.avatarLabel.shadow(anyImage: avatar, anyView: cell.viewForShadow, color: UIColor.systemBlue.cgColor)
    } else {
      cell.avatarLabel.shadow(anyImage: avatar, anyView: cell.viewForShadow, color: UIColor.green.cgColor)
    }
    cell.configure(name: name, image: avatar, about: nil, online: online)
    cell.buttonPressed = { [weak self] in
      self?.performSegue(withIdentifier: "allPhotos", sender: UIButton())
    }
    
    //cell.delegate = self
    
    return cell
  }
}

extension DetailedFriendCollectionViewController: DetailedFriendDelegate {
  func namePressed(id: Int) {
    Session.self.shared.userId = id
    //self.navigationController?.pushViewController(DetailedFriendCollectionViewController(), animated: true)
    let storyBoard: UIStoryboard = UIStoryboard(name: "Main", bundle: nil)
    let collectionViewController = storyBoard.instantiateViewController(withIdentifier: "DetailedFriendCollectionViewController") as! DetailedFriendCollectionViewController
    collectionViewController.modalPresentationStyle = .fullScreen
    self.present(collectionViewController, animated: true, completion: nil)
    //self.present(DetailedFriendCollectionViewController, animated: true, completion: nil)
    //print("gogo")
  }
}


