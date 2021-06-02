//
//  Photos.swift
//  VKapp_RudenkoD
//
//  Created by Dmitry on 30.05.2021.
//

import Foundation
import RealmSwift

// MARK: - Photos
class Photos: Codable {
    let response: Response

    init(response: Response) {
        self.response = response
    }
}

// MARK: - Response
class Response: Codable {
    let count: Int
    let items: [Item]

    init(count: Int, items: [Item]) {
        self.count = count
        self.items = items
    }
}

// MARK: - Item
class Item: Object, Codable {
  var sizes: [Size]
  @objc dynamic var albumID, id, date: Int
  @objc dynamic var text: String
  @objc dynamic var hasTags: Bool
  @objc dynamic var ownerID: Int

    enum CodingKeys: String, CodingKey {
        case albumID = "album_id"
        case id, date, text, sizes
        case hasTags = "has_tags"
        case ownerID = "owner_id"
    }

//    init(albumID: Int, id: Int, date: Int, text: String, sizes: [Size], hasTags: Bool, ownerID: Int) {
//        self.albumID = albumID
//        self.id = id
//        self.date = date
//        self.text = text
//        self.sizes = sizes
//        self.hasTags = hasTags
//        self.ownerID = ownerID
//    }
}

// MARK: - Size
class Size: Object, Codable {
  @objc dynamic var width, height: Int
  @objc dynamic var url: String
  @objc dynamic var type: String

//    init(width: Int, height: Int, url: String, type: String) {
//        self.width = width
//        self.height = height
//        self.url = url
//        self.type = type
//    }
}



