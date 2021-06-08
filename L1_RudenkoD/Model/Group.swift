//
//  Group.swift
//  VKapp_RudenkoD
//
//  Created by Dmitry on 11.04.2021.
//

import Foundation
import RealmSwift

struct oldGroup {
  var name: String
  var description: String?
  var groupImage: UIImage?
  var isMember: Bool = false
}

extension oldGroup: Equatable {
  static func == (lhs: oldGroup, rhs: oldGroup) -> Bool {
          return
              lhs.name == rhs.name
  }
}

class Groups: Object, Decodable {
  @objc dynamic var id = 0
  @objc dynamic var photo50 = ""
  @objc dynamic var name = ""
  @objc dynamic var descr = ""

  enum TopCodingKeys: String, CodingKey {
    case response
    case items
  }

  enum CodingKeys: String, CodingKey {
    case id
    case name
    case photo50 = "photo_50"
    case descr = "status"

  }
   convenience required init(from decoder: Decoder) throws {
    self.init()
    let usersValues = try decoder.container(keyedBy: CodingKeys.self)
    self.id = try usersValues.decode(Int.self, forKey: .id)
    self.photo50 = try usersValues.decode(String.self, forKey: .photo50)
    self.name = try usersValues.decode(String.self, forKey: .name)
    self.descr = try usersValues.decode(String.self, forKey: .descr)
  }
}

class GroupsResponse: Decodable {
  let response: GroupsItems
}

class GroupsItems: Decodable {
  let items: [Groups]
}


      
