//
//  FriendListFactory.swift
//  VKapp_RudenkoD
//
//  Created by Dmitry on 15.08.2021.
//

import Foundation

class FriendListFactory {
  
  func constructFriendListModel(friends: [FriendsModelStruct]) -> [FriendsViewModel] {
    friends.compactMap({self.getFriendModel(from: $0)})
}
  
  private func getFriendModel(from friend: FriendsModelStruct) -> FriendsViewModel? {
    let fullName = friend.firstName + " " + friend.lastName
    guard let photoURL = URL(string: friend.photo50) else { return nil }
    return FriendsViewModel(fullName: fullName, photoURL: photoURL)
  }
}
