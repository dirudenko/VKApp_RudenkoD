//
//  Session.swift
//  VKapp_RudenkoD
//
//  Created by Dmitry on 21.05.2021.
//

import Foundation

final class Session: NSObject {
  static let shared = Session()
  private override init() {
    super.init()
  }
  
  var token = String()
  var userId = [Int]()
  var numberOfFriends = Int()
  var selfId = String()
}



