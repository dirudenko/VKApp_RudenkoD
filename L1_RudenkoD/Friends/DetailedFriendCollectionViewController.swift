//
//  DetailedFriendCollectionViewController.swift
//  VKapp_RudenkoD
//
//  Created by Dmitry on 11.04.2021.
//

import UIKit
import Alamofire

class DetailedFriendCollectionViewController: UICollectionViewController {
  
  @IBOutlet weak var photoAlbumButton: UIBarButtonItem!
  private let cellReuseIdentifier = "DetailedFriendCollectionViewCell"
  var friendId: Int?
  private var user = User()
  
  override func viewDidLoad() {
    super.viewDidLoad()
    getUser() {  [weak self] user in
      self?.user = user
      print(user.time)
    }
    let nibFile = UINib(nibName: cellReuseIdentifier, bundle: nil)
    self.collectionView.register(nibFile, forCellWithReuseIdentifier: cellReuseIdentifier)
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

extension DetailedFriendCollectionViewController {
  func getUser(completion: @escaping (User) -> Void) {
    let baseUrl = "https://api.vk.com/method/"
    let token = Session.shared.token
    let parameters: Parameters = [
      "user_ids": friendId!,
      "fields": "nickname,photo_200_orig,online,last_seen",
      "access_token": token,
      "v": "5.131"]
    let path = "users.get"
    let url = baseUrl + path
    AF.request(url, method: .get, parameters: parameters).responseData {
      response in
      guard let data = response.value else { return }
  //    print(data.prettyJSON)
      let user = try! JSONDecoder().decode(User.self, from: data)
      completion(user)
      DispatchQueue.main.async { [weak self] in
        self?.collectionView.reloadData()
      }
    }
  }
}
