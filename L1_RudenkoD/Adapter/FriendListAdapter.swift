//
//  FriendListAdapter.swift
//  VKapp_RudenkoD
//
//  Created by Dmitry on 14.08.2021.
//

import Foundation
import RealmSwift

final class FriendListAdapter {
  
  private let networkService = NetworkServices()
  private var realmNotificationTokens: [String: NotificationToken] = [:]
  private var token = NotificationToken()
  
  func getFriends(completion: @escaping ([FriendsModelStruct]) -> Void) {
    guard let realm = try? Realm() else { return }
    let realmFriends = realm.objects(FriendsModel.self)    
    token = realmFriends.observe{ (changes) in
      
      switch changes {
      case .update(let results, deletions: _, insertions: _, modifications: _) :
        var friends: [FriendsModelStruct] = []
        for item in results {
          friends.append(self.friendList(from: item))
        }
        completion(friends)
      case .error(let error):
        fatalError(error.localizedDescription)
      case .initial(_):
        break
      }
    }
  }
  
  private func friendList(from rlmFriends: FriendsModel) -> FriendsModelStruct {
    return FriendsModelStruct(id: rlmFriends.id,
                              lastName: rlmFriends.lastName,
                              photo50: rlmFriends.photo50,
                              firstName: rlmFriends.firstName,
                              online: rlmFriends.online)
  }
}
