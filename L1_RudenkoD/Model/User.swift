//
//  User.swift
//  VKapp_RudenkoD
//
//  Created by Dmitry on 11.04.2021.
//

import Foundation
import UIKit

struct User {
  var name: String
  var age: UInt
  var avatar: UIImage?
  var photoArray = [UIImage]()
  var job: String?
}


//// MARK: - Users
//class Users: Codable {
//    let response: Response
//
//    init(response: Response) {
//        self.response = response
//    }
//}
//
//// MARK: - Response
//class Response: Codable {
//    let count: Int
//    let items: [Item]
//
//    init(count: Int, items: [Item]) {
//        self.count = count
//        self.items = items
//    }
//}
//
//// MARK: - Item
//class Item: Codable {
//    let canAccessClosed: Bool
//    let id: Int
//    let nickname, lastName: String
//    let photo50: String
//    let trackCode: String
//    let isClosed: Bool
//    let firstName: String
//
//    enum CodingKeys: String, CodingKey {
//        case canAccessClosed
//        case id, nickname
//        case lastName
//        case photo50
//        case trackCode
//        case isClosed
//        case firstName
//    }
//
//    init(canAccessClosed: Bool, id: Int, nickname: String, lastName: String, photo50: String, trackCode: String, isClosed: Bool, firstName: String) {
//        self.canAccessClosed = canAccessClosed
//        self.id = id
//        self.nickname = nickname
//        self.lastName = lastName
//        self.photo50 = photo50
//        self.trackCode = trackCode
//        self.isClosed = isClosed
//        self.firstName = firstName
//    }
//}






//// MARK: - Users
//class Users: Decodable {
//    let response: Response
//
//    init(response: Response) {
//        self.response = response
//    }
//}
//
//// MARK: - Response
//class Response: Decodable {
//    let items: [Item]
//
//    init(items: [Item]) {
//        self.items = items
//    }
//}
//
//// MARK: - Item
//class Item: Decodable {
//    let id: Int
//    let lastName: String
//    let photo50: String
//    let firstName: String
//
//    enum CodingKeys: String, CodingKey {
//        case id = "id"
//        case lastName = "last_name"
//        case photo50 = "photo_50"
//        case firstName =  "first_name"
//    }
//
//    init(id: Int, lastName: String, photo50: String, firstName: String) {
//        self.id = id
//        self.lastName = lastName
//        self.photo50 = photo50
//        self.firstName = firstName
//    }
//}



// MARK: - Item
//class Users: Decodable {
//  var id = 0
//  var lastName = ""
//  var photo50 = ""
//  var firstName = ""
//
//  enum TopCodingKeys: String, CodingKey {
//    case items
//    case response
//  }
//
////  enum CodingKeys: String, CodingKey {
////    case items
////  }
//
//  enum CodingKeys: String, CodingKey {
//    case id
//    case lastName = "last_name"
//    case photo50 = "photo_50"
//    case firstName = "first_name"
//  }
//   convenience required init(from decoder: Decoder) throws {
//    self.init()
//    let container = try decoder.container(keyedBy: TopCodingKeys.self)
//
//    //let meta = try container.nestedContainer(keyedBy: TopCodingKeys.self, forKey: .items)
//    var userArray = try container.nestedUnkeyedContainer(forKey: .items)
//    let usersValues = try userArray.nestedContainer(keyedBy: CodingKeys.self)
//    self.id = try usersValues.decode(Int.self, forKey: .id)
//    self.lastName = try usersValues.decode(String.self, forKey: .lastName)
//    self.photo50 = try usersValues.decode(String.self, forKey: .photo50)
//    self.firstName = try usersValues.decode(String.self, forKey: .firstName)
//  }
//}
//
//class FriendsResponse: Decodable {
//  let list: [Users]
//}

class Users: Codable {
    let response: Response?

    init(response: Response) {
        self.response = response
    }
}

// MARK: - Response
class Response: Codable {
    let items: [Item]

    init(items: [Item]) {
        self.items = items
    }
}

// MARK: - Item
class Item: Codable {
    let id: Int
    let lastName: String
    let photo50: String
    let firstName: String

    enum CodingKeys: String, CodingKey {
        case id
        case lastName = "last_name"
        case photo50 = "photo_50"
        case firstName = "first_name"
    }

    init(id: Int, lastName: String, photo50: String, firstName: String) {
        self.id = id
        self.lastName = lastName
        self.photo50 = photo50
        self.firstName = firstName
    }

}

