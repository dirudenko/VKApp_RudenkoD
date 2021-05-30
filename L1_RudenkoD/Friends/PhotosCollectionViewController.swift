//
//  PhotosCollectionViewController.swift
//  VKapp_RudenkoD
//
//  Created by Dmitry on 19.04.2021.
//

import UIKit
import Alamofire

class PhotosCollectionViewController: UICollectionViewController {
  
  private let cellReuseIdentifier = "PhotosCollectionViewCell"
  var friendId: Int?
  //var albumArray = [Item]()
  private var urlArray = [String]()
  var indexPhoto: Int?
  
  override func viewDidLoad() {
    super.viewDidLoad()
    getPhoto() {  [weak self] photos in
      let albumArray = photos
      albumArray.forEach {
        $0.sizes.forEach {
          if $0.type.rawValue == "m"  {
            self?.urlArray.append($0.url)
          }
        }
      }
    }
    
    let nibFile = UINib(nibName: cellReuseIdentifier, bundle: nil)
    self.collectionView.register(nibFile, forCellWithReuseIdentifier: cellReuseIdentifier)
  }
  
  override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
    if segue.identifier == "fullImage" {
      let controller = segue.destination as! AnimatedPhotosViewController
      controller.indexPhoto = self.indexPhoto
      controller.friendId  = self.friendId
    }
  }
  
  override func numberOfSections(in collectionView: UICollectionView) -> Int {
    return 1
  }
  
  override func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
    return urlArray.count
  }
  
  override func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
    //var image = [UIImage]()
    guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: cellReuseIdentifier, for: indexPath) as? PhotosCollectionViewCell else { return UICollectionViewCell() }
    var image = UIImage()
    let string = urlArray[indexPath.row]
      if let urlImage = getImage(from: string) {
        image = urlImage
    }
    cell.configure(image: image)
    return cell
  }
  
  override func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
    indexPhoto = indexPath.row
    performSegue(withIdentifier: "fullImage", sender: (Any).self)
  }
  
  
}

extension PhotosCollectionViewController: UICollectionViewDelegateFlowLayout {  
  func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize
  {
      let cellSize = CGSize(width: 160, height: 186)
      return cellSize
  }

  func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat
  {
      return 10
  }

  func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAt section: Int) -> UIEdgeInsets
  {
    let sectionInset = UIEdgeInsets(top: 10, left: 10, bottom: 10, right: 10)
      return sectionInset
  }
}

extension PhotosCollectionViewController {
  func getPhoto(completion: @escaping ([Item]) -> Void) {
    let baseUrl = "https://api.vk.com/method/"
    let token = Session.shared.token
    let parameters: Parameters = [
      "count": 199,
      "owner_id": friendId!,
      "no_service_albums": 1,
      "access_token": token,
      "v": "5.77"]
    let path = "photos.getAll"
    let url = baseUrl + path
    AF.request(url, parameters: parameters).responseData {
      response in
      guard let data = response.value else { return }
      let photos = try! JSONDecoder().decode(Photos.self, from: data).response.items
      completion(photos)
      DispatchQueue.main.async { [weak self] in
        self?.collectionView.reloadData()
      }
    }
  }
}
