//
//  FriendStruct.swift
//  VKapp_RudenkoD
//
//  Created by Dmitry on 14.08.2021.
//

import Foundation


struct FriendsModelStruct {
  let id: Int
  let lastName: String
  let photo50: String
  let firstName: String
  let online: Int
  var name: String {
    firstName + " " + lastName
  }
}
