//
//  PhotosCollectionViewController.swift
//  VKapp_RudenkoD
//
//  Created by Dmitry on 19.04.2021.
//

import UIKit

class PhotosCollectionViewController: UICollectionViewController {
  
  private let cellReuseIdentifier = "PhotosCollectionViewCell"
  var friendId: Int?
  private var urlArray = [String]()
  private var indexPhoto: Int?
  private let networkService = NetworkServices()
  private let databaseService = DatabaseServiceImpl()
  
  var presenter: PhotoPresenterProtocol!
  
  override func viewDidLoad() {
    super.viewDidLoad()
    let nibFile = UINib(nibName: cellReuseIdentifier, bundle: nil)
    self.collectionView.register(nibFile, forCellWithReuseIdentifier: cellReuseIdentifier)
    presenter = PhotoPresenter(view: self, networkService: networkService, databaseService: databaseService)
  }
  
  override func viewWillAppear(_ animated: Bool) {
    super.viewWillAppear(animated)
    presenter.getPhoto(collectionView: self.collectionView)
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
    guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: cellReuseIdentifier, for: indexPath) as? PhotosCollectionViewCell else { return UICollectionViewCell() }
    guard let string = URL(string: urlArray[indexPath.row]) else { return UICollectionViewCell() }
    let image = asyncPhoto(cellImage: cell.photoView, url: string)
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
}

extension PhotosCollectionViewController: PhotoProtocol {
  func success() {
    guard let albumArray = presenter.photos,
          let id = friendId else { return }
    albumArray.filter {
      $0.ownerID == id
    }
    .forEach {
      let item = $0.sizeList
      item.forEach{
        if $0.type == "m"  {
          self.urlArray.append($0.url)
        }
      }
    }
    self.collectionView.reloadData()
  }
}
