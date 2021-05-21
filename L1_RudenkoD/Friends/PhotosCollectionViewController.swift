//
//  PhotosCollectionViewController.swift
//  VKapp_RudenkoD
//
//  Created by Dmitry on 19.04.2021.
//

import UIKit

class PhotosCollectionViewController: UICollectionViewController {
  
  private let cellReuseIdentifier = "PhotosCollectionViewCell"
  var indexUser: Int?
  var photoArray: [UIImage] = []
  var indexPhoto: Int?
  
  override func viewDidLoad() {
    super.viewDidLoad()
    let nibFile = UINib(nibName: cellReuseIdentifier, bundle: nil)
    self.collectionView.register(nibFile, forCellWithReuseIdentifier: cellReuseIdentifier)
    if let index = indexUser {
    photoArray = DataStorage.shared.usersArray[index].photoArray
    }
  }
  
  override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
    if segue.identifier == "fullImage" {
      let controller = segue.destination as! AnimatedPhotosViewController
     // print(indexUser! , indexPhoto!)
      controller.indexPhoto = self.indexPhoto
      controller.indexUser  = self.indexUser
    }
  }
  
  override func numberOfSections(in collectionView: UICollectionView) -> Int {
    // #warning Incomplete implementation, return the number of sections
    return 1
  }
  
  
  override func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
    // #warning Incomplete implementation, return the number of items
    //guard let userIndex = index else { return 0 }
    return photoArray.count
  }
  
  override func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
    //var image = [UIImage]()
    guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: cellReuseIdentifier, for: indexPath) as? PhotosCollectionViewCell else { return UICollectionViewCell() }
    let image = photoArray[indexPath.row]
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

