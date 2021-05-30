//
//  Photos.swift
//  VKapp_RudenkoD
//
//  Created by Dmitry on 30.05.2021.
//

import Foundation

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
class Item: Codable {
    let albumID, id, date: Int
    let text: String
    let sizes: [Size]
    let hasTags: Bool
    let ownerID: Int

    enum CodingKeys: String, CodingKey {
        case albumID = "album_id"
        case id, date, text, sizes
        case hasTags = "has_tags"
        case ownerID = "owner_id"
    }

    init(albumID: Int, id: Int, date: Int, text: String, sizes: [Size], hasTags: Bool, ownerID: Int) {
        self.albumID = albumID
        self.id = id
        self.date = date
        self.text = text
        self.sizes = sizes
        self.hasTags = hasTags
        self.ownerID = ownerID
    }
}

// MARK: - Size
class Size: Codable {
    let width, height: Int
    let url: String
    let type: TypeEnum

    init(width: Int, height: Int, url: String, type: TypeEnum) {
        self.width = width
        self.height = height
        self.url = url
        self.type = type
    }
}

enum TypeEnum: String, Codable {
    case m = "m"
    case o = "o"
    case p = "p"
    case q = "q"
    case r = "r"
    case s = "s"
    case w = "w"
    case x = "x"
    case y = "y"
    case z = "z"
}

