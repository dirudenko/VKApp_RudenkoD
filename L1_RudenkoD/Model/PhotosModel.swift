//
//  Photos.swift
//  VKapp_RudenkoD
//
//  Created by Dmitry on 30.05.2021.
//

import Foundation
import RealmSwift


class PhotosModel: Object, Decodable {
  @objc dynamic var albumID = 0
  @objc dynamic var id = 0
  @objc dynamic var ownerID = 0
  let sizeList  = List<Sizes>()
  
  enum CodingKeys: String, CodingKey {
    case albumID = "album_id"
    case ownerID = "owner_id"
    case id
    case sizes
  }
  
  convenience required init(from decoder: Decoder) throws {
    self.init()
    let container = try decoder.container(keyedBy: CodingKeys.self)
    self.albumID = try container.decode(Int.self, forKey: .albumID)
    self.id = try container.decode(Int.self, forKey: .id)
    self.ownerID = try container.decode(Int.self, forKey: .ownerID)
    let photoArray = try container.decodeIfPresent([Sizes].self, forKey: .sizes) ?? [Sizes()]
    sizeList.append(objectsIn: photoArray)
  }
  
  override class func primaryKey() -> String? {
          return "id"
      }
  
}

class PhotoResponse: Decodable {
  let response: PhotoItems
}

class PhotoItems: Decodable {
  let items: [PhotosModel]
}

class Sizes: Object, Decodable {
  @objc dynamic var width = 0
  @objc dynamic var height = 0
  @objc dynamic var url = ""
  @objc dynamic var type = ""
  
  enum CodingKeys: String, CodingKey {
    case type
    case url
    case width
    case height
  }
  
  convenience required init(from decoder: Decoder) throws {
    self.init()
  let container = try decoder.container(keyedBy: CodingKeys.self)
  self.url = try container.decode(String.self, forKey: .url)
  self.height = try container.decode(Int.self, forKey: .height)
  self.width = try container.decode(Int.self, forKey: .width)
  self.type = try container.decode(String.self, forKey: .type)
  }
}

