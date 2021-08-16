//
//  FriendsPresenter.swift
//  VKapp_RudenkoD
//
//  Created by Dmitry on 22.06.2021.
//

import UIKit
import RealmSwift
import Alamofire

protocol FriendsProtocol: AnyObject {
  func success()
}

protocol FriendsPresenterProtocol: AnyObject {
  init(view: FriendsProtocol)
  func getFriends()
  var friends: [FriendsModelStruct]? {get set}
  var friendViewModels: [FriendsViewModel] {get set}
}

class FriendsPresenter: Operation, FriendsPresenterProtocol {
  
  var friends: [FriendsModelStruct]?
  let view: FriendsProtocol
  private let adapter = FriendListAdapter()
  private let friendViewModelFactory = FriendListFactory()
  var friendViewModels = [FriendsViewModel]()
  private let networkService = NetworkServices()
  private let databaseService = DatabaseServiceImpl()
  
  
  required init(view: FriendsProtocol) {
    self.view = view
  }
  
  func getFriends() {
    self.networkService.getFriendList(userId: nil) { [weak self] friends in
      guard let self = self else { return }
      for item in friends {
        self.databaseService.save(object: item, update: true)
      }
    }
    
    self.adapter.getFriends { [weak self] friends in
      guard let self = self else { return }
      self.friends = friends
      self.friendViewModels = self.friendViewModelFactory.constructFriendListModel(friends: friends)
      self.view.success()
    }
  }
}

