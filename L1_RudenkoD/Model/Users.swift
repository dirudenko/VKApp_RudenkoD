//
//  User.swift
//  VKapp_RudenkoD
//
//  Created by Dmitry on 11.04.2021.
//

import Foundation
import RealmSwift

struct oldUser {
  var name: String
  var age: UInt
  var avatar: UIImage?
  var photoArray = [UIImage]()
  var job: String?
}

class User: Object, Decodable {
  @objc dynamic var id = 0
  @objc dynamic var platform = 0
  @objc dynamic var time = 0.0
  @objc dynamic var lastName = ""
  @objc dynamic var photo200 = ""
  @objc dynamic var firstName = ""
  @objc dynamic var online = 0
  @objc dynamic var about = ""
  @objc dynamic var name: String {
  firstName + " " + lastName
}
  @objc dynamic var lastOnline: String {
    let date = Date(timeIntervalSince1970: time)
    let dateFormatter = DateFormatter()
    dateFormatter.timeZone = TimeZone(abbreviation: "MSK")
    dateFormatter.locale = NSLocale.current
    dateFormatter.dateFormat = "dd-MM-yyyy HH:mm"
    return dateFormatter.string(from: date)
  }

  enum TopCodingKeys: String, CodingKey {
    case response
  }

  enum CodingKeys: String, CodingKey {
    case id
    case lastName = "last_name"
    case photo200 = "photo_200_orig"
    case firstName = "first_name"
    case about = "status"
    case lastSeen = "last_seen"
    case online
  }
  
  enum LowCodingKeys: String, CodingKey {
    case platform
    case time
  }
  
   convenience required init(from decoder: Decoder) throws {
    self.init()
    let container = try decoder.container(keyedBy: TopCodingKeys.self)
    var userArray = try container.nestedUnkeyedContainer(forKey: .response)
    let usersValues = try userArray.nestedContainer(keyedBy: CodingKeys.self)
    self.id = try usersValues.decode(Int.self, forKey: .id)
    self.lastName = try usersValues.decode(String.self, forKey: .lastName)
    self.photo200 = try usersValues.decode(String.self, forKey: .photo200)
    self.firstName = try usersValues.decode(String.self, forKey: .firstName)
    self.online = try usersValues.decode(Int.self, forKey: .online)
    self.about = try usersValues.decode(String.self, forKey: .about)
    
    let metainfo = try usersValues.nestedContainer(keyedBy: LowCodingKeys.self, forKey: .lastSeen)
    self.time = try metainfo.decode(Double.self, forKey: .time)
    self.platform = try metainfo.decode(Int.self, forKey: .platform)
  }
}

class UsersModel: Object, Decodable {
  @objc dynamic var id = 0
  @objc dynamic var lastName = ""
  @objc dynamic var photo50 = ""
  @objc dynamic var firstName = ""
  @objc dynamic var online = 0
  @objc dynamic var name: String {
  firstName + " " + lastName
}
  

  enum TopCodingKeys: String, CodingKey {
    case response
    case items
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
}

class FriendsResponse: Decodable {
  let response: FriendsItems
}

class FriendsItems: Decodable {
  let items: [UsersModel]
}
