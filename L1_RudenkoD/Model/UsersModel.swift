//
//  User.swift
//  VKapp_RudenkoD
//
//  Created by Dmitry on 11.04.2021.
//

import Foundation
import RealmSwift

class UsersModel: Object, Decodable {
  @objc dynamic var id = 0
  @objc dynamic var lastName = ""
  @objc dynamic var photo50 = ""
  @objc dynamic var firstName = ""
  @objc dynamic var online = 0
  @objc dynamic var name: String {
  firstName + " " + lastName
}

  enum CodingKeys: String, CodingKey {
    case id
    case lastName = "last_name"
    case photo50 = "photo_50"
    case firstName = "first_name"
    case online
  }
   convenience required init(from decoder: Decoder) throws {
    self.init()
    let usersValues = try decoder.container(keyedBy: CodingKeys.self)
    self.id = try usersValues.decode(Int.self, forKey: .id)
    self.lastName = try usersValues.decode(String.self, forKey: .lastName)
    self.photo50 = try usersValues.decode(String.self, forKey: .photo50)
    self.firstName = try usersValues.decode(String.self, forKey: .firstName)
    self.online = try usersValues.decode(Int.self, forKey: .online)
  }
  
  override class func primaryKey() -> String? {
          return "id"
      }
}

class FriendsResponse: Decodable {
  let response: FriendsItems
}

class FriendsItems: Decodable {
  let items: [UsersModel]
}
