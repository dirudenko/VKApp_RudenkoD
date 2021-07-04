//
//  DetailedFriendCollectionViewController.swift
//  VKapp_RudenkoD
//
//  Created by Dmitry on 11.04.2021.
//

import UIKit

class DetailedFriendCollectionViewController: UICollectionViewController {
    
  private let cellReuseIdentifier = "DetailedFriendCollectionViewCell"
  private var user = UserModel()
  private var id = Int()

  private let networkService = NetworkServices()
  private let databaseService = DatabaseServiceImpl()
  
  var presenter: UserPresenterProtocol!
  
  override func viewDidLoad() {
    super.viewDidLoad()
    let nibFile = UINib(nibName: cellReuseIdentifier, bundle: nil)
    self.collectionView.register(nibFile, forCellWithReuseIdentifier: cellReuseIdentifier)
    presenter = UserPresenter(view: self, networkService: networkService, databaseService: databaseService)
  }
  
  override func viewWillAppear(_ animated: Bool) {
    super.viewWillAppear(animated)
    guard let id = Session.shared.userId.last else { return }
    self.id = id
    presenter.getFriend(collectionView: self.collectionView, id: id)
  }
  
//  override func numberOfSections(in collectionView: UICollectionView) -> Int {
//    return 1
//  }
  
  override func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
    return  1
  }
  
  override func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
    guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: cellReuseIdentifier, for: indexPath) as? DetailedFriendCollectionViewCell else
    { return UICollectionViewCell() }
    let name = user.name
    var online = "сейчас"
    var avatar =  UIImage()
    let string = user.photo200
    let about = user.about
    if let image = getImage(from: string) {
      avatar = image
    }
    if user.online == 0 {
      online = user.lastOnline
      cell.avatarLabel.shadow(anyImage: avatar, anyView: cell.viewForShadow, color: UIColor.systemBlue.cgColor)
    } else {
      cell.avatarLabel.shadow(anyImage: avatar, anyView: cell.viewForShadow, color: UIColor.green.cgColor)
    }
    cell.configure(name: name, image: avatar, about: about, online: online)
    cell.buttonPressed = { [weak self] in
      self?.performSegue(withIdentifier: "allPhotos", sender: UIButton())
    }
    cell.cellDelegate = self
    return cell
  }
  
  override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
    if segue.identifier == "allPhotos" {
      let controller = segue.destination as! PhotosCollectionViewController
      controller.friendId = id
    }
  }
}

extension DetailedFriendCollectionViewController: DetailedViewDelegate {
  func goVC(id: Int) {
    Session.shared.userId.append(id)
    let vc = self.storyboard?.instantiateViewController(withIdentifier: "DetailedFriendCollectionViewController") as! DetailedFriendCollectionViewController
    self.navigationController?.pushViewController(vc, animated: true)
  }
}

extension DetailedFriendCollectionViewController: UserProtocol {
  func success() {
    guard let friends = presenter.friend,
    let user = friends.first(where: {$0.id == self.id})
    else { return }
    self.user = user
    self.collectionView.reloadData()
  }
}




