//
//  PhotosPresenter.swift
//  VKapp_RudenkoD
//
//  Created by Dmitry on 23.06.2021.
//

import UIKit
import RealmSwift

protocol PhotoProtocol: AnyObject {
  func success()
}

protocol PhotoPresenterProtocol: AnyObject {
  init(view: PhotoProtocol, networkService: NetworkServicesProtocol, databaseService: DatabaseServiceProtocol)
  func getPhoto(collectionView: UICollectionView)
  func getAnimatedPhoto()
  var photos: Results<PhotosModel>? {get set}
}

class PhotoPresenter: PhotoPresenterProtocol {
  
  
  var photos: Results<PhotosModel>?
  let view: PhotoProtocol
  let id  = Session.shared.userId.last!
  weak var networkService: NetworkServicesProtocol!
  weak var databaseService: DatabaseServiceProtocol!
  
  required init(view: PhotoProtocol, networkService: NetworkServicesProtocol, databaseService: DatabaseServiceProtocol) {
    self.view = view
    self.networkService = networkService
    self.databaseService = databaseService
  }
  
  func getPhoto(collectionView: UICollectionView) {
    networkService.getPhoto(id: id) { [weak self] photos in
      guard let self = self else { return }
      for item in photos {
        self.databaseService.save(object: item, update: true)
      }
      self.photos = self.databaseService.read(object: PhotosModel(), tableView: nil, collectionView: collectionView)
      self.view.success()
    }
  }
  
  func getAnimatedPhoto() {
    self.photos = self.databaseService.read(object: PhotosModel(), tableView: nil, collectionView: nil)
    self.view.success()
  }
  
}


