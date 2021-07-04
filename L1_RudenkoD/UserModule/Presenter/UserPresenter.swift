//
//  UserPresenter.swift
//  VKapp_RudenkoD
//
//  Created by Dmitry on 22.06.2021.
//

import UIKit
import RealmSwift

protocol UserProtocol: AnyObject {
  func success()
}

protocol UserPresenterProtocol: AnyObject {
  init(view: UserProtocol, networkService: NetworkServicesProtocol, databaseService: DatabaseServiceProtocol)
  func getFriend(collectionView: UICollectionView, id: Int)
  var friend: Results<UserModel>? {get set}
}

class UserPresenter: UserPresenterProtocol {
  
  var friend: Results<UserModel>?
  let view: UserProtocol
  weak var networkService: NetworkServicesProtocol!
  weak var databaseService: DatabaseServiceProtocol!
  
  required init(view: UserProtocol, networkService: NetworkServicesProtocol, databaseService: DatabaseServiceProtocol) {
    self.view = view
    self.networkService = networkService
    self.databaseService = databaseService
  }
  
  func getFriend(collectionView: UICollectionView, id: Int) {
    networkService.getUserInfo(id: id) { [weak self] user in
      guard let self = self else { return }
        self.databaseService.save(object: user, update: true)
      self.friend = self.databaseService.read(object: UserModel(), tableView: nil, collectionView: collectionView)
      self.view.success()
    }
  }
}
