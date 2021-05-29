//
//  гыукудуьуте.swift
//  VKapp_RudenkoD
//
//  Created by Dmitry on 29.05.2021.
//

import Foundation

struct UserElement: Codable {
    let address: Address
    let phone, website: String
    let id: Int
    let company: Company
    let username, email, name: String
}

// MARK: - Address
struct Address: Codable {
    let geo: Geo
    let street, suite, city, zipcode: String
}

// MARK: - Geo
struct Geo: Codable {
    let lat, lng: String
}

// MARK: - Company
struct Company: Codable {
    let name, catchPhrase, bs: String
}


