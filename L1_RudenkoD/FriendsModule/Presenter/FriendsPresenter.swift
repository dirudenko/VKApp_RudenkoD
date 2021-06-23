//
//  FriendsPresenter.swift
//  VKapp_RudenkoD
//
//  Created by Dmitry on 22.06.2021.
//

import UIKit
import RealmSwift

protocol FriendsProtocol: AnyObject {
  func success()
}

protocol FriendsPresenterProtocol: AnyObject {
  init(view: FriendsProtocol, networkService: NetworkServicesProtocol, databaseService: DatabaseServiceProtocol)
  func getFriends(tableView: UITableView)
  var friends: Results<FriendsModel>? {get set}
}

class FriendsPresenter: FriendsPresenterProtocol {
  
  var friends: Results<FriendsModel>?
  let view: FriendsProtocol
  
  weak var networkService: NetworkServicesProtocol!
  weak var databaseService: DatabaseServiceProtocol!
  
  required init(view: FriendsProtocol, networkService: NetworkServicesProtocol, databaseService: DatabaseServiceProtocol) {
    self.view = view
    self.networkService = networkService
    self.databaseService = databaseService
  }
  
  func getFriends(tableView: UITableView) {
    networkService.getFriendList(userId: nil) { [weak self] users in
      guard let self = self else { return }
      for item in users {
        self.databaseService.save(object: item, update: true)
      }
      self.friends = self.databaseService.read(object: FriendsModel(), tableView: tableView, collectionView: nil)
      self.view.success()
    }
  }
}
